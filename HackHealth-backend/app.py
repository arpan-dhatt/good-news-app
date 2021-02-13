import json
import hashlib
from fastapi import FastAPI
from scraper import json_sources

app = FastAPI(title="GoodNews",
              version="1.0")


def send(sources, categories, page):
    sources = sources.split(",")  # [nytimes]
    if "ALL" in sources:
        sources = list(json_sources().keys())
    categories = categories.split(",")  # [Business]
    if "ALL" in categories:
        categories = ["World", "Business", "Sports", "Sci/Tech"]
    categories = ["Sci/Tech" if x == "scitech" else x.capitalize() for x in categories]

    info = {
        "sources": sources,
        "category": categories,
        "page": page
    }
    print(info)
    with open("article_data/metrics.json", "r") as f:
        index = json.load(f)
    index = [x for x in index if x['source'] in sources]
    index = [x for x in index if x['category'] in categories]
    index = index[10 * page:10 * page + 10]
    print(len(index))
    return prepare_payload(index)


@app.get("/categorical")
def task_handler(sources: str, category: str, page: int):
    return send(sources,
                category,
                page)


@app.get("/recommendations")
def task_handler(sources: str, categories: str, suggested: str, page: int):
    return send(sources,
                categories,
                page)


def prepare_payload(index):
    for loc, article in enumerate(index):
        index[loc] = {"title": article["data"]["title"].replace('\n', '').replace(" ,", ","),
                      "subtitle": article["data"]["description"].replace('\n', '').replace(" ,", ","),
                      "date": article["data"]["published"].replace('\n', '').replace(" ,", ","),
                      "description": article["metrics"]["summary"].replace('\n', '').replace(" ,", ","),
                      "thumbnail": article["data"]["meta_img"],
                      "body": article["data"]["body"],
                      "article": article["data"]["link"],
                      "categories": ["SciTech" if article["category"] == "Sci/Tech" else article["category"]],
                      "uuid": int(hashlib.sha256(article["id"].encode('utf-8')).hexdigest(), 16) % 10 ** 8
                      }
    payload = {
        "item_count": len(index),
        "items": index
    }
    return payload


@app.get("/sources")
def sources():
    sources = json_sources().keys()
    return {"sources": list(sources)}


@app.get("/categories")
def categories():
    categories = ["World", "Business", "Sports", "Sci/Tech"]
    return {"categories": categories}

