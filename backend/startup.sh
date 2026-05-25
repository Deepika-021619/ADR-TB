#!/bin/bash

cd /home/site/wwwroot/backend

pip install -r backend/requirements.txt

uvicorn main:app --host 0.0.0.0 --port 8000


