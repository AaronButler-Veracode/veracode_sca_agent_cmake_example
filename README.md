# veracode_sca_agent_cmake_example

This project will run a Veracode SCA agent scan on a cmake C++ project:
https://github.com/mumble-voip/mumble/tree/master

To use this project you will need to clone it locally, update the variables.txt with your SCA Agent token and build the docker image.

To build from the project root run:
`docker build -t cplusplus .`

To run the SCA Agent scan run:
`docker run --rm --env-file ./variables.txt  --name cplusplus cplusplus srcclr scan /home/testing/muble/build`

<img width="1905" height="554" alt="image" src="https://github.com/user-attachments/assets/98895ae7-bf2a-4786-ac6b-c71e56ac3715" />

<img width="1269" height="995" alt="image" src="https://github.com/user-attachments/assets/a240cd55-8dc3-45e9-b415-0425fcb74f4b" />
