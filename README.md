[![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/being_stockholm-api/badge.svg?branch=development)](https://coveralls.io/github/CraftAcademy/being_stockholm-api?branch=development)
[![Build Status](https://semaphoreci.com/api/v1/craftacademy/being_stockholm-api/branches/development/badge.svg)](https://semaphoreci.com/craftacademy/being_stockholm-api)

# Project Title

## **Being Stockholm !**
Being Stockholm engages citizens to digitally share, map and illustrate how they use the region. Residents shares geotagged photos of how they work and play along with a short caption, so we can produce:
* A data point map to illustrate where Stockholmers work and play
* A word cloud map to describe how Stockholmers work and play
* A curated map of recommendations by Stockholmers for Stockholmers

We want to inspire residents to explore new parts of the city and try out activities. Everyone can share their experiences, regardless of how long they have lived in Stockholm and their language.

We can help urban planners see how the city is used and changing, so that the urban development process can be more responsive, and even change the perceptions of regeneration areas, to attract new and established Stockholmers alike.

Companies can attract and retain internationals with a preview of living and working in Stockholm. It can be part of their post-relocation care to help the new staff, their partner and family feel more settled to reduce the risk of their relocation ending prematurely.

Active and engaged residents will help Stockholm remain as a top city to live and work, attract internationals to keep Sweden competitive, and a platform to promote Sweden to the world.

***This is an actual project that we were offered the chance to develop as our final project with [Craft Academy](https://www.craftacademy.se/english/). Our goal is to build a Minimum Viable Product, which means there is lots of space for improvements.***

***This was a three weeks project (June 10th - June 28th).***

# User Stories

Check the whole design sprint and user story history of the project in [this](https://www.pivotaltracker.com/n/projects/2353360) Pivotal Tracker board.

# Deployment & GitHub

This application consists of a back-end API and a front-end Client.

The GitHub repository for the API is [here](https://github.com/CraftAcademy/being_stockholm-api) and the one for the Client is [here](https://github.com/CraftAcademy/being_stockholm-client).

The API is deployed using Heroku on [this address](https://being-stockholm.herokuapp.com/).

The client, which is where everything happens, is deployed via Netlify [here](https://being-stockholm.netlify.com/).

# Tests, Test Coverage & CI

### API
The API part of the application was request and unit tested using [Rspec](https://rspec.info/).

To be able to run the tests, run `bundle install` in your terminal as soon as you fork this repository.

You must also have the database migrations in place, in order for everything to work properly. So in your terminal run `rails db:migrate`. In case this command produces an error, you can run `rails db:drop db:setup`.

After that, use `bundle exec rspec` to run all tests avoiding any conflicts with the gems of this repo and your locally installed gems.

Unit and request tests can be found in the `spec/models` and `spec/requests` folders respectively.

[Coveralls](https://coveralls.io/) was used to measure the API's test coverage.

[Semaphore CI](https://semaphoreci.com/) was used for continious integration.

### CLIENT
The Client part of the application was acceptance tested using [Cypress](https://www.cypress.io/).

All API calls are handled using mock data `json` files, which can be found in the `cypress/fixtures` folder. Before you run any tests, you first need to asssign the `development` value to `axios.defaults.baseURL` and `authUrl` variables found in `src/index.js` and  `src/reduxTokenAuthConfig.js` respectively. Then you run `npm install` in your terminal to download all packages.

After that, use `npm run cy:open` to launch a local server instance of the application and run all acceptance tests of Cypress.

Acceptance tests can be found in the `cypress/integration` folder.

# Built With

* API with [Ruby on Rails](https://rubyonrails.org/) version 5.2.3.
* API with [Ruby](https://www.ruby-lang.org/en/) version 2.4.1.
* Client with [React](https://reactjs.org/).
* Client was styled using [Semantic UI](https://react.semantic-ui.com/).
* Client uses theming functionality of Semantic-UI precompiled with [gulp](https://gulpjs.com/). All relevant files can be found in `src/semantic` folder.

# Authors

* **Carla**- [GitHub Profile](https://github.com/Carrosen) - [Portfolio Website](https://portfolio-carla-rosen.netlify.com/)
* **Zane**- [GitHub Profile](https://github.com/zanenkn) - [Portfolio Website](https://zanenkn.netlify.com/)
* **Stefan** - [GitHub Profile](https://github.com/stefankarlberg) - [Portfolio Website](https://mystifying-einstein-390384.netlify.com/)
* **Felix** - [GitHub Profile](https://github.com/leiter007) - [Portfolio Website](https://felix-react-portfolio.netlify.com/)
* **Boa** - [GitHub Profile](https://github.com/SnailCoder1) - [Portfolio Website](https://boamatule.netlify.com/)
* **raptorf1** - [GitHub Profile](https://github.com/raptorf1) - [Portfolio Website](https://gtomaras-portfolio.netlify.com/)

# License

This project is licensed under the [MIT](https://opensource.org/licenses/MIT) license.

# Acknowledgments

* [PurpleBooth](https://github.com/PurpleBooth) for this README template.
* [Rails Guides](https://guides.rubyonrails.org/index.html) for the detailed documentation.
* [Stack Overflow](https://stackoverflow.com/) for the guidance during the "difficult" times during development.
* [React documentation](https://reactjs.org/docs/getting-started.html) for the support we needed on related issues.

# Special Appreciations
3 months ago, we embarked on a journey to the unknown universe of coding. It was a demanding experience, that made us stronger and substantially more competent and knowledgeable, when it comes to modern web development practices.

That journey was made possible and smoother, because of the support from our coaches in Craft Academy. They were always next to us, helping us, mentoring us, teaching us, even during weekends, sacrificing their personal time.

Thank you:
* [Oliver](https://github.com/oliverochman)
* [Thomas](https://github.com/tochman)
* [Faraz](https://github.com/faraznaeem)
* [Noel](https://github.com/Noelryn)
* [Greg](https://github.com/GergKllai1)
* [Adi](https://github.com/kianaditya)