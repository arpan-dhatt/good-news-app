from newspaper import Article
import torch
from simpletransformers.classification import ClassificationModel  # Custom categories
from transformers import pipeline
import json
from classifiers.summarizer.extractive import ExtractiveSummarizer  # pulled from https://github.com/HHousen/TransformerSum, with minor changes


class Classifier:
    def __init__(self):
        self.json_in = "article_data/metadata.json"
        self.json_out = "article_data/metrics.json"
        self._sentiment = pipeline("sentiment-analysis")
        self._summarizer = ExtractiveSummarizer.load_from_checkpoint("outputs/epoch=3.ckpt")

        self.cuda_available = torch.cuda.is_available()
        self._categorizer = ClassificationModel(
            "bert", "outputs/checkpoint-15000-epoch-1/", use_cuda=self.cuda_available
        )
        self.categories = ["World", "Sports", "Business", "Sci/Tech"]
        self.articles = []
        print("Initialized")

    def scrape_articles(self):
        for url in self.url_list:
            article = Article(url)
            article.download()
            article.parse()
            self.articles.append(article)

    def create_metrics(self, metrics=["sentiment"]):
        out = []
        articles = {}
        with open(self.json_in, "r") as f:
            article_list = json.load(f)
        for index in range(len(article_list)):
            try:
                print(len(out))
                article = article_list[index]
                link = article["data"]["link"]
                uid = article["id"]
                a = Article(link)
                a.download()
                a.parse()
                sentiment = self.analyze_sentiment(a)
                if sentiment[0]["label"] == "POSITIVE":
                    category = self.analyze_category(a)
                    article["metrics"] = {"sentiment": sentiment[0]}
                    article["category"] = category
                    article["metrics"]["keywords"] = a.meta_keywords
                    article["metrics"]["summary"] = self.analyze_summary(a)
                    article["data"]["description"] = a.meta_description
                    article["data"]["body"] = a.text
                    article["data"]["meta_img"] = a.meta_img
                    out.append(article)
                    articles[uid] = a
                    if len(out) % 10 == 0:
                        with open(self.json_out, "w") as outfile:
                            json.dump(out, outfile)
            except Exception:
                pass
        with open(self.json_out, "w") as outfile:
            json.dump(out, outfile)

    def analyze_sentiment(self, article):
        return self._sentiment([f"{article.title}. {article.meta_description}"])

    def analyze_summary(self, article):
        return self._summarizer.predict(article.text, num_summary_sentences=2)

    def analyze_category(self, article):
        return self.categories[self._categorizer.predict([f"{article.title}. {article.meta_description}"])[0][0]]
