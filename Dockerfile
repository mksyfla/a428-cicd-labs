FROM node:16
RUN npm install
RUN npm run build
CMD [ "npm", "start" ]