# # XM_SDET Tasks Solution

## Main Tech stacks
- [Python](https://www.python.org/) ver 3.8.2
- [Robot Framework](https://robotframework.org/) ver 6.0.2
- [Flask](https://flask.palletsprojects.com/en/2.0.x/) ver 2.0.3
- [pabot](https://github.com/mkorpela/pabot) 'Used for parallel execution' ver 2.11.0
- [Robot Requests Library](https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html) ver 0.9.4

## Project Structure
The project consists of following:
 * [Project](./)
   * [app](./app.py) Flask app
   * [tests](./tests) Contains test suites
   * [resources](./resources) Contains test data and helper functions
   * [result](./result) Contains robot result files and api logs

## Pre-requisites
- Python is in path. This can be checked with following command
```python3 -V```

## How to run tests
- Install all dependencies using following command under [requirements](./requirements.txt)
```
pip3 install -r requirements.txt
```
- Run the following command in terminal from projects root dir. ```--outputdir``` sets the dir for result files
```
pabot --outputdir result tests
```
- To run single suite (with sequential tests), run one of the followings:
```
robot --outputdir result tests/api_tests.robot 
```
```
robot --outputdir result tests/performance_test.robot
```
