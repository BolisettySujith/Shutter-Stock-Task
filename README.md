# Shutter Stock Task

### Problem Statement

Implement an app that fetches pictures from the Shutterstock API.

- The API documentation is here: https://developers.shutterstock.com/api/v2
- Please use the search endpoint of Shutterstock API, making sure that new pictures will be fetched and shown when the user scrolls to the end of the list.(Pagination)
- Create a Menu Options in the App Bar which display different Assets Type.
- Please put internet check.
- Implement Pull TO Refresh functionality.
- Use Hive For local storage.
- Use Json Serialisation for Parsing Json to Model classes. (https://docs.flutter.dev/data-and-backend/serialization/json)
- You are completely free in design choices (MVC, MVVM, MVP) and state management techniques (Bloc, Provider, GetX etc)
- Main focus should be on a highly performant app (smooth scrolling & lag-free UI)


### **Packages Used**
- Statemanagement used: **BLoC**
- Database used: **Hive**
- Shutter Stock API
  - The API documentation is here: [Shutterstock.com](https://developers.shutterstock.com/api/v2)


## Shutter Stock Design


### Project Structure

![projectFolderStructure](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/665ed3b3-a903-4c50-a5ba-338a89505c40)

## Overview


**Data**: 

1. This is the data layer of the project, it will handle all the network connection, local db connection, json to model convertion. 
2. This data directory contains three more directories:
   - **dataproviders** : This directory contains the files that helps in accessing the internet. These files are begin called from the repository to access the data from the internet.
   - **models** : This directory contains all the models used in the project. Each model will also contains their respective `.g.dart` files.
   - **repository** : The files in this directory is responsible for  connecting the BLoC layer with the data layer. BLoC access the data it needs from the data layer via these repositories.
  
**BLoC** : Business Logic Components

1. This directory contains all the blocs used in the project, each bloc directory contains bloc, states, events files.
2. In this project there is only one bloc, i.e `shutterstock_bloc`.
    - **shutterstock_bloc.dart:**
      - This file likely contains the definition of the `ShutterstockBloc` class, which is responsible for managing the business logic of the Shutterstock-related features in your Flutter app.
      - The BLoC class typically handles data processing, business rules, and communicates with external services or repositories.
    - **shutterstock_events.dart:**
      - This file probably defines a set of events or actions that can occur in the Shutterstock feature. These events are often dispatched by the UI or other components to trigger specific changes in the application state.
      - The following are the events present in the Shutterstock BLoC
        - GetShutterStockAPIImagesEvent
        - GetShutterStockLocalImagesEvent
        - ChangeAssetTypeEvent
        - ResetShutterStockImagesEvent
    - **shutterstock_state.dart:**
      - This file likely contains the definition of the `ShutterstockState` class, representing the current state of the Shutterstock feature.
      - The state holds information about the data to be displayed, error states, loading states, or any other relevant information needed to render the UI.
      - The following are the states present in the Shutterstock BLoC
        - ShutterStockInitialState
        - ShutterStockRemoteImagesLoading
        - ShutterStockLocalImagesLoading
        - ShutterStockImagesLoaded
        - ShutterStockImagesLoadingFailed
        - NoInternet
        - ConnectionTimeout
        - NoShutterStockImagesFound


**Presentation** : 
1. The the is the view layer of the project, it contains the widgets and app pages.
2. This directory contains two more directories:
    - **Pages** : This directory contains all the pages in the project, like home page, loading page..etc.
    - **Widgets** : This directory contains common widgets that are using in the app pages.

**Res** :
1. This directory contains the common resources used in the project, like app constants, app colors, app urls, and common contant widgets..etc

## Class Diagram

![finalClassDiagram (1)](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/b3c15a72-df11-46ac-9d15-dd066ff5988e)

## App Flow

![1](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/133075f7-678e-4fc1-be8d-4f09a5a7135c)

![2](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/b5084a15-8719-4b76-ac8b-4f8b09d40288)

![3](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/e152ec92-97da-4343-96bf-5b3356590bed)


### Network API Calls (When There is Network Connection)

![4](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/e968cea6-b1d5-4917-9615-c4db92c8d930)

![5](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/1d654ffa-9433-457d-8181-63dfb9c706fe)

![6](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/ff200c80-9e64-449b-817b-7d215fab13b0)

### Local Database - Hive (When There is No Network Connection)

![7](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/23d3d54b-eae2-43c7-b202-f473a32c1167)

![8](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/23a2de34-5e3c-4ac8-b7ff-3a62c2e45eb0)

![9](https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/bfa6d4aa-3ebd-4dc5-9783-296aa658db48)


## **Demo 📱**
  <table>
       <tr>
       <td align="center">Pop Up Menu</td>
       <td align="center">loading Images From API</td>
       <td align="center">Loading More Images</td>
       <td align="center">Internet Reconnected</td>
      </tr>
       <tr>
       <td><img src="https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/ff83298d-0f83-4432-bf83-0aa5fed7be65"></td>
       <td><img src="https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/3fc2f5d3-1d22-4b74-8070-11abb3937e6d"></td>
       <td><img src="https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/79f9cfa1-4f9e-42ea-82b9-d8c1c7f711b7"></td><td><img src="https://github.com/BolisettySujith/Shutter-Stock-Task/assets/73323807/d3f9c825-d518-4c44-89b6-1c4ce05ec9d1"></td>
      </tr>
  </table>
