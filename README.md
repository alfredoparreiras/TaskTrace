
![Logo](https://i.postimg.cc/wBx8Tvw3/Screenshot-2023-12-16-at-1-53-21-PM.png)


# TaskTrace
TaskTrace is a task management tool that simplifies tracking tasks for both individuals. It provides an easy overview of each task's progress from start to end, improving efficiency


## Demo

![Launch](https://media.giphy.com/media/RkuLrA46UiFYp9h6u9/giphy.gif)

http://tasktrace.app
## Authors

- [@alfredosilva](https://github.com/alfredoparreiras)


## 🛠 Skills
Java - JavaEE - MySQL - BootStrap - Docker - VPS


## Features

- Login / Logout
- SignUp
- Mobile Friendly
- Cross platform

## Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Primary | ![#316CF4](https://via.placeholder.com/10/316CF4?text=+) #316CF4 |
| Background | ![#FFF](https://via.placeholder.com/10/FFFFFF?text=+) #FFFFFF |
| Accent | ![#EC7248](https://via.placeholder.com/10/EC7248?text=+) #EC7248 |


## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

- `DATABASE_URL`
- `DATABASE_USER`
- `DATABASE_PASSWORD`
- `MYSQL_ROOT_PASSWORD`
- `MYSQL_DATABASE`

## Deployment

This project was made using JavaEE plataform and for this reason to properly run this project you must configure a Java EE enviroment with TomCat WebServer.

For this project I create a Docker Container, if you are familiar with it, you can use to this container to set up this Java EE enviroment.

For now, MySQL Database is not dockerized. So you need to create a new database and updated the enviroment variables.

- [Container](https://hub.docker.com/r/alfredosilva/tasktrace-app)





