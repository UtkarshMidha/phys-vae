#!/bin/bash

echo "Running pendulum: physonly"
bash pendulum_train.sh physonly

echo "Running pendulum: nnonly0"
bash pendulum_train.sh nnonly0

echo "Running pendulum: nnonly1"
bash pendulum_train.sh nnonly1

echo "Running pendulum: physnn"
bash pendulum_train.sh physnn

echo "✅ All pendulum variants finished."
