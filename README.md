# Group 3: Monty MATLAB project


Silly Walk Classification with LSTM and K-NN Algorithms

## Description
This project aims to classify gait patterns as either "Silly Walk" or "Normal Walk" using LSTM (Long Short-Term Memory) and k-NN (K-Nearest Neighbors) algorithms. The classification results are displayed through a graphical user interface (GUI) implemented in MATLAB.

The project consists of the following main components:

Data Extraction: The input gait data is preprocessed and windowed.

Model Training: LSTM and k-NN models are trained using the preprocessed data.

Classification: The trained models are used to classify gait patterns as "Silly Walk" or "Normal Walk".

GUI Development: A graphical user interface is created to provide a user-friendly display of the classification results.
Note that only the LSTM model is used to develop the GUI because of its higher accuracy.

To run the GUI and observe the classification results, execute the GUI_start.m script. 


## Installation
To use this project, follow the steps below:

Clone the repository to your local machine:
```
git clone https://gitlab.lrz.de/ldv/teaching/monty-matlab/montymatlab2023/group-3.git
```
Ensure you have MATLAB installed on your computer. If not, you can also use MATLAB Online.

Open MATLAB (or MATLAB Online) and navigate to the project directory.

Add the project folder and its subfolders to the MATLAB path.

Run the GUI_start.m script to launch the GUI.

## Usage
Launch the GUI by running the GUI_start.m script.

After launching, a welcome message and options for importing gait data or viewing a demo of Silly Walk animation will be displayed.

To import gait data, click on the button "Sure! Import my gait!". Select the appropriate data file when prompted.

The GUI will plot the acceleration data and classify the gait pattern as "Silly Walk" or "Normal Walk" based on the model trained by the LSTM algorithm.

The classification result, along with the classification runtime, will be shown in the GUI.

To view a demo of Silly Walk animation, click on the button "How does Silly Walk look like?". The animation will be displayed as a GIF.

To choose another data file and re-run the classification, click on the  button "Choose another data".

## Dependencies
The project has the following dependencies:

- MATLAB (or MATLAB Online)
- Deep Learning Toolbox (for LSTM model training)
- Statistics and Machine Learning Toolbox (for k-NN model training)
- Image Processing Toolbox (for displaying GIF animation)
- Other MATLAB built-in functions and libraries

## Video
Link to our presentation video: https://youtu.be/IZinj8PDOr4
