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

For anyone who has unnecessary things, GiveNTake is a marketplace that can take those things to where they are necessary, without the hassle of shipping or pricing.


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
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code (Logical View), using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system in a horizontal decomposition, defining layers and implementation concepts, such as the user interface, business logic and concepts.

Example of _UML package diagram_ showing a _logical view_ of the Eletronic Ticketing System (to be accompanied by a short description of each package):

![LogicalView](https://user-images.githubusercontent.com/9655877/160585416-b1278ad7-18d7-463c-b8c6-afa4f7ac7639.png)

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams (Deployment View) or component diagrams (Implementation View), separate or integrated, showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for ESOF are, for example, frameworks for mobile applications (such as Flutter).

Example of _UML deployment diagram_ showing a _deployment view_ of the Eletronic Ticketing System (please notice that, instead of software components, one should represent their physical/executable manifestations for deployment, called artifacts in UML; the diagram should be accompanied by a short description of each node and artifact):

![DeploymentView](https://user-images.githubusercontent.com/9655877/160592491-20e85af9-0758-4e1e-a704-0db1be3ee65d.png)

### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system integrating as much technologies we can.

In this subsection please describe which feature, or part of it, you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a small part of a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).


## Project management
Software project management is the art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we recommend each team to adopt a set of project management practices and tools capable of registering tasks, assigning tasks to team members, adding estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Common practices of managing iterative software development are: backlog management, release management, estimation, iteration planning, iteration development, acceptance tests, and retrospectives.

You can find below information and references related with the project management in our team: 

* Backlog management: Product backlog and Sprint backlog in a [Github Projects board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/64);
* Release management: [v0](#), v1, v2, v3, ...;
* Sprint planning and retrospectives: 
  * plans: screenshots of Github Projects board at begin and end of each iteration;
  * retrospectives: meeting notes in a document in the repository;
 
