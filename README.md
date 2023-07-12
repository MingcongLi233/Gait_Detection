# Group 3: Monty MATLAB project


Silly Walk Classification with LSTM and KNN Algorithms

## Description
This project aims to classify gait patterns as either "Silly Walk" or "Normal Walk" using LSTM (Long Short-Term Memory) and KNN (K-Nearest Neighbors) algorithms. The classification results are displayed through a graphical user interface (GUI) implemented in MATLAB.

The project consists of the following main components:

Data Processing: The input gait data is preprocessed and windowed to extract features.
Model Training: LSTM and KNN models are trained using the extracted features.
Classification: The trained models are used to classify gait patterns as "Silly Walk" or "Normal Walk".
GUI Development: A graphical user interface is created to provide a user-friendly display of the classification results.
To run the GUI and observe the classification results, execute the GUI_start.m script.

## Installation
To use this project, follow the steps below:

Clone the repository to your local machine:
```
git clone https://gitlab.lrz.de/ldv/teaching/monty-matlab/montymatlab2023/group-3.git
```
Ensure you have MATLAB installed on your computer.

Open MATLAB and navigate to the project directory.

Run the GUI_start.m script to launch the GUI.

## Usage
Launch the GUI by running the GUI_start.m script.

The GUI will open, displaying the welcome message and options for importing gait data or viewing a demonstration of silly walk animation.

To import gait data, click on the "Sure! Import my gait!!" button. Select the appropriate data file when prompted.

The GUI will display the acceleration data plot and classify the gait pattern as "Silly Walk" or "Normal Walk" based on the selected algorithm.

The classification result, along with the classification runtime, will be shown in the GUI.

To view a demonstration of silly walk animation, click on the "How does Silly Walk look like?" button. The animation will play using a GIF file.

To choose another data file and re-run the classification, click on the "Choose another data" button.

## Dependencies
The project has the following dependencies:

- MATLAB (version XYZ or later)
- Deep Learning Toolbox (for LSTM model training)
- Statistics and Machine Learning Toolbox (for KNN model training)
- Image Processing Toolbox (for displaying GIF animation)
- Other MATLAB built-in functions and libraries
