# README

This app uses
Ruby version '2.3.5'
Postgresql

To create the database locally run in terminal:
rails db:create
rails db:migrate
rails db:seed

Seed file creates few examples of delivery offices with postcodes.

Test include system tests:
-visiting the home page
-adding a new office
-searching for offices in a radius with expected one result
-searching for offices with no results

and basic controllers test for index, new and create.
