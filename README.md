# News App

  

A news developed with flutter for android and ios devices.

  

## Requirements

  

- Internet Access

  

## How It Works

The News App was developed using Flutter. The application requires the provider and http package to operate. The http package is used to retrieve data from a server using the URL provided. The data is decoded and converted to a list of “NewsItems”. The “NewsItem” is a class that is used to define how each piece of data that represents the news should look like. The NewsItems are stored in a list. The process of retrieving data is wrapped in a try-catch block. The try-catch block throws an error if there are any issues retrieving the data.
##
The provider package is used to control app wide state. That is most of the applications logic is done in the provider files. The provider package helps to transfer data to specific widgets to prevent the entire application from rebuilding when data changes.
##
The home screen widget retrieves the list of “NewsItems” from the provider package and stores the data in a variable. The ListView builder widget is used to build a list of ListTiles (widget) to display the data. The list tiles have spaces for a title, subtitle and trailing item. The title is the title of the news item, the subtitle is the author’s name and the trailing item is an arrow. When the user taps on a ListTile, the ID of the news item is passed to the detail page. In the detail page the news item with the corresponding id is filtered from the list of “NewsItems” using the “findById” method. The page renders the title of the news object in the appbar. The news image fills a third of the screen. The title and author of the news object are also rendered below the image. Finally the news text is also rendered below the author.

## Link to demo Video
- https://1drv.ms/v/s!AiPiEZurCyDRi-omv-p2mPQkuFD5cw