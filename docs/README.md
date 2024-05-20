# _GiveNTake_ Development Report

Welcome to the documentation pages of _GiveNTake_!

You can find here details about _GiveNTake_, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities: 

* [Business modeling](#Business-Modelling) 
  * [Product Vision](#Product-Vision)
  * [Features and Assumptions](#Features-and-Assumptions)
  * [Elevator Pitch](#Elevator-pitch)
* [Requirements](#Requirements)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-And-Design)
  * [Logical architecture](#Logical-Architecture)
  * [Physical architecture](#Physical-Architecture)
  * [Vertical prototype](#Vertical-Prototype)
* [Project management](#Project-Management)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

Eduardo Baltazar (up202206313@fe.up.pt)

Joana Noites (up202202684@fe.up.pt)

João Santos (up202205794@fe.up.pt)

Marta Silva (up202208258@fe.up.pt)

Sara Cortez (up202205636@fe.up.pt)

---
## Business Modelling

### Product Vision

Get rid of your junk! GiveNTake can give your unused things a second life, without the hassle of shipping or pricing.


### Features and Assumptions

 - User Registration and Login - users can create or log into their accounts
 - Product Listing - users can list any product they want to give away for free,with images and a pick up location
 - Location Based Matching - the app will display listings near the user
 - Reviews and Ratings - users can leave reviews and ratings for each other based on their experiences
 - User Profiles - each user has their unique profile, where they can view their ratings and listings
 - Handle Requests - a user can deny or accept a pick-up request for their listing
 - Make Requests - a user can request a product that other user is giving away

### Elevator Pitch

Making way for reusability and extending everyday objects’ lifespans has never been so essential. Do you have a lot of things you no longer use at home and don't know what to do with? Our app allows you to give and receive products for free, in a very easy way! Simply upload your products and wait for someone near you to show interest. You can acquire any other product that other users make available. Through our reviews section, you can give and see reviews made by other users to ensure the security and reliability you need. So, if you don't feel comfortable giving your product to a certain user, you can deny it. Fighting waste has never been so simple!

## Requirements

### Domain model

You can see here a preliminary domain model exploring the main entities and relations of our product.
The classes include:
* **User:** Our App exists for them. In the context of our App, the terms of user and account are interchangeable. The **User**, or Account Owner, logs in via a **phone number** and **password** and is identified by a **Name** and a **Picture**. They give and take **Product**s to/from other **User**s. The **User** gets reviewed and writes reviews, makes requests and gets requests.
* **Product:** Our App exists because of them. The name **Product** refers, actually to the advertisement of a **Product** owned by a user. They have a required **title** and an optional **description**. So being, each product is uploaded in the app to have a short lifetime and be deleted as soon as possible.
* **Review:** Reviews are a way of assuring safety and reliability. They are exchanged between **Users**, and are meant to be saved, grouped by target and have its average calculated. They have a mandatory 0 to 5 **star rating** and an optional **Message**.
* **Request:** Requests are the way of communication. **Users** exchange requests to state that they are interested in a product. They are meant to have an even shorter lifetime than products, ceasing to exist when they are **accepted** or **declined**.
  
Image:
 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/blob/main/docs/giventake_uml.png"/>
</p>


## Architecture and Design
### Logical architecture

In order to provide long-term maintenance of the code and allow easy understanding about, we will divide our project in different sections:

* **Blocs:** each bloc will encapsulate a set of related functionalities. Therefore, each bloc will take an event as input, process them and emits states. An event represents an action that happens in an app usually trigger by user iterations. A state represents the state of the app in each moment. Therefore, when the state changes, the corresponding UI components are rebuilt to reflect the updated state. 
* **Components:** Components created by our team that will be use throughout the development of this project to maintain visual consistency and reducing code duplication.
* **Screens:** Responsible for drawing the app and allowing interactions between the user and the program.
* **Packages:** Module that establishes the communications between the app and Firebase.



Example of _UML package diagram_ showing a _logical view_ of the Eletronic Ticketing System (to be accompanied by a short description of each package):

![LogicalView](https://user-images.githubusercontent.com/9655877/160585416-b1278ad7-18d7-463c-b8c6-afa4f7ac7639.png)

### Physical architecture
Regarding our app´s physical architecture, we feature two distinct identities: the Firebase server and the app itself. This way, the user interacts solely with the app, which is connected to the Firebase server. The server contains the database with all the information required for the app to function properly. 

Regarding technologies, for the frontend we used Flutter (Dart programming language) and Firebase for the backend.

Example of _UML deployment diagram_ showing a _deployment view_ of the Eletronic Ticketing System (please notice that, instead of software components, one should represent their physical/executable manifestations for deployment, called artifacts in UML; the diagram should be accompanied by a short description of each node and artifact):

![DeploymentView](https://user-images.githubusercontent.com/9655877/160592491-20e85af9-0758-4e1e-a704-0db1be3ee65d.png)

### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system integrating as much technologies we can.

In this subsection please describe which feature, or part of it, you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a small part of a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).


## Project management

All the management of the project is done using this [Github Project board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/2) where all the issues are organized in Product backlog and Iteration backlog. Therefore, our project has 5 columns: Backlog, Sprint Backlog, In Progress, Done and User Stories. At the end of each iteration, the tasks that weren't finished are passed to the Sprint Backlog, so that the In Progress column appears empty at the end of every iteration.

# Releases
- [v0](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/releases/tag/vertical-prototype)
- [v1](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T21/releases/tag/sprint-1)
- [v2](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/releases/tag/sprint-2)

## Iteration **#1**

At the beginning of this iteration we intented to focus on product increment consist, most importantly, of:
-All products listed in main page;
-Products can be added by users;
-Users can log in;
-Product details can be accessed.
-Request products

At the end of the first iteration we considered the sprint was successful as we managed to implement several challenging things. We implemented almost everything, expect for product request that is still a work in progress and we found a bug when uploading photos of products that will be fixed in the next Sprint. Sprint 0 backlog was updated with improvements on the components that weren't matched/yet done and work was assigned to every member. Even though sprint work was uneven among us, we hope further sprints might balance the workload so as in the release every member has developed around the same. We hope to improve delivery in the next sprint by getting more work done, since we haven't accomplished a third of the App as of the end of the 1st sprint. 

Before:\
![image](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/assets/131759998/56bf4c59-7ae3-438c-be11-fc9f1f91d970)

After:\
![end](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/assets/131759998/e5961c1f-b683-40d6-9e80-05d0f0408138)


## Iteration **#2**

At the beginning of the second iterations our main goals were to implement the following features:
- Search bar, allowing the user to search any product by name or description;
- Request products by users;
- Check other users information, reviews and products on their profile screen;

  During this sprint, most of the team was more available so we assigned tasks accordingly. This sprint went really well since the bugs from the previous sprint were sucessfully fixed and we implemented almost everything that we expected at the begging of the sprint. However, there is still some work to do on the request and acceptance of products by users and bugs to fix on the users products on their profile.

Before:\
![Screenshot from 2024-05-03 18-40-43](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/assets/131995213/c28ccf36-72f9-4523-abb2-abba05999f61)

After:\
![Screenshot from 2024-05-03 18-53-05](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/assets/131995213/6cb4def4-4451-44a1-a5b9-d04b07b028f2)


## Iteration **#3**

At the beginning of Sprint 3 we intended to:
- users being able to make reviews of other users;
- users being able to see their profile and edit their informations;
- users being able to accept requests of their products;
- improve product details screen

This sprint were sucessfully completed since all features are now correctly implemented. During the sprint we found some bugs, but we were able to correct them so that the app works properly.


Before:\
<img width="920" alt="image" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/assets/145434267/636fac61-6c75-48e2-908a-6de552cced59">

After:\
<img width="956" alt="image" src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC05T2/assets/145434267/14603ab2-7b90-4a36-a0cd-96932a7b6d57">



Common practices of managing iterative software development are: backlog management, release management, estimation, iteration planning, iteration development, acceptance tests, and retrospectives.

You can find below information and references related with the project management in our team: 

* Backlog management: Product backlog and Sprint backlog in a [Github Projects board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/64);
* Release management: [v0](#), v1, v2, v3, ...;
* Sprint planning and retrospectives: 
  * plans: screenshots of Github Projects board at begin and end of each iteration;
  * retrospectives: meeting notes in a document in the repository;
 
