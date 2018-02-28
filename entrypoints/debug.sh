#!/bin/bash

webdriver-manager update
nohup webdriver-manager start &
npm test