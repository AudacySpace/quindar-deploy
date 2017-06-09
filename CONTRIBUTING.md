# Contributing to Quindar-GMAT

This guide covers ways in which you can become a part of the ongoing development of Quindar. Outlined in this file are:

* Reporting an Issue
* Contributing to the Quindar-deploy code

## Code of Conduct

Quindar is committed to fostering a welcoming, collaborative and passionate community. If you encounter any unacceptable behavior, please report the issue to the Quindar team; we are here to help. Our standards is to use welcoming and inclusive language, being respectful of differing viewpoints, accepting constructive criticism, showing empathy towards other community members, and focusing on what is best for the community. As contributors and maintainers of Quindar, we pledge to respect everyone who contributes by posting issues, updating documentation, submitting pull requests, providing feedback in comments, and any other activities.

Communication through any of Quindar's channels (GitHub, IRC, mailing lists, Google+, Twitter, etc.) must be constructive and never resort to personal attacks, trolling, public or private harassment, insults, or other unprofessional conduct. We promise to extend courtesy and respect to everyone involved in this project regardless of gender, gender identity, sexual orientation, disability, age, race, ethnicity, religion, or level of experience. We expect anyone contributing to Quindar to do the same.

If any member of the community violates this code of conduct, the maintainers of Quindar may take action, removing issues, comments, and PRs or blocking accounts as deemed appropriate. If you are subject to or witness unacceptable behavior, or have any other concerns, please email us at quindar@quindar.space.

## Reporting an Issue
Quindar uses GitHub Issue Tracking to track issues (primarily bugs and contributions of new code). 
If you found a bug,
* Ensure that the bug is new by searching on Github under [Issues](https://github.com/quindar/quindar-deploy/issues).
* If you are unable to find an existing issue, open a new one. Include a clear and descriptive title, steps to reproduce the issue, expected and actual behavior. Include code samples, screenshots wherever needed.

## Contributing to the Quindar-deploy code

Look at the README file for instructions on how to run Quindar in a local development environment. Any changes to the docker build files used to deploy Quindar should be tested on / compatible with multiple platforms (pc, mac, linux). To make a change, please create a feature branch (under the develop branch), make changes as proposed; then submit a pull request to the develop branch. 

### Style Guides
We're not super strict on style guides yet, but as Quindar grows and we increasingly automate the DevOps / QA processes, consistent coding style is increasingly important. To future proof your code, please consult the following guidelines:

* [Angular v1 Guide](https://github.com/johnpapa/angular-styleguide/blob/master/a1/README.md)
* [Javascript Guide](https://google.github.io/styleguide/jsguide.html)
* [CSS+JS Guide](https://github.com/airbnb/javascript/tree/master/css-in-javascript)
* [HTML5 Guide](https://www.w3schools.com/html/html5_syntax.asp)
* [Dockerfile Guide](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)

## To Do

* dockerhub integration for faster deployment
* security hardening
