#!/bin/bash

source ./db.config

DATABASE=$1
DBA="$MY $DATABASE"

$MY -e "DROP DATABASE IF EXISTS $DATABASE"
$MY -e "CREATE DATABASE $DATABASE"

# creazione tabelle, viste e procedure da dump
$DBA < $QD/createTT_ALL.sql

