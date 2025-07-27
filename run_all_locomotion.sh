#!/bin/bash

# Run both locomotion model variants one after the other
bash locomotion_train.sh nnonly
bash locomotion_train.sh physnn
