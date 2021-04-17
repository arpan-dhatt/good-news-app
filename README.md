# GoodNewz (Best Overall HackHealth 2021)
1. [DevPost Article](https://devpost.com/software/goodnewz-7f9ge0)

## Inspiration
As Covid has transformed the world, it has brought to light some fundamental issues in our society, one of the largest being Mental Health. In the past year, things just kept getting more and more crazier, and people were constantly left on edge wondering what is next for the world. Unfortunately, most people’s window in the world, news, is driven by a desire for attention, which leads to sensationalization, division, and most prevalently, negativity. Studies have shown that the news cycles of impending doom and hate seriously harm a person's psyche, and so we wondered, what could we do?

## What it does
GoodNewz provides a platform full of, you guessed it, good news! It parses through various publications, identifies which ones are positive, and categorizes them. The user then interacts with the app which loads good news based on the user’s preferences. The user can then see these articles in a modified reading mode (to get away from the clutter of news websites), and keep track of their feelings while reading these articles through a diary system. The diary system allows one to keep track of their feelings over time to see changes in mood etc. 

## How we built it
There are 2 main components to our app.

First is a backend that dynamically scrapes the web for articles every 30 minutes. The articles are then parsed and key features are extracted from the file, including the article text, article heading image, date, and description. Both custom and pre-built machine learning models are used to determine the sentiment of the article, create a summary for it (see https://arxiv.org/abs/1908.08345), and categorize the article by subject topic. The only positive news is added to the overall index, and made available to the client-side news app via an API. The backend was built in python using FastAPI and PyTorch Lightning, using huggingface’s transformer package for pre-trained models. 

The frontend contains a few main sections. First is the feed which contains the latest news from the backend. Second is a journal system that allows users to keep track of their thoughts and feelings as they are reading the news, so they can see how they changed over time. Then there is a section that divides the news into categories for more target consumption. The app also contains a profile system so a user can better curate their experience. Finally, we also have a custom web view that displays the article without the clutter or normal web pages in a more reader-friendly way. 

## Challenges we ran into
One of the main challenges we had was displaying the article inside of the app. We had to go through 3 default methods of displaying a webpage (we later found out it was very difficult to dynamically change the website URL when clicking on a new article using these default methods) and we ended up creating our own way to display web pages using parsed data. We also had initial issues in getting the data to load on the app from the backend due to unfamiliarity with the combine framework which we were able to overcome with the help of StackOverflow!

## What we learned
We mainly learned a few concepts related to creating a dynamic app that interacts with the backend and a user's local storage. On the front-end, we learned the combined framework to pull data from a backend to the app, about using CoreData and UserDefaults to manage local storage more efficiently, and about the various types of displaying websites inside of an iPhone app including SafariViewController, WebKit, and creating our web view. On the Backend, we learned how to make a personalization algorithm.

## What's next for GoodNewz
We hope to better train our model with a larger dataset (we were unable to find a sufficiently labeled dataset), in order to categorize the stories into more categories to create a personalization algorithm. We also hope to add variety to the display options of the feed.
