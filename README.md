# SDD

**[TIM2024]** Official implementation of paper "Sparse Prior Is Not All You Need: When Differential Directionality Meets Saliency Coherence for Infrared Small Target Detection".

## Abstract
Infrared small target detection is crucial for the efficacy of infrared search and tracking systems. Current tensor decomposition methods emphasize representing small targets with sparsity but struggle to separate targets from complex backgrounds due to insufficient use of intrinsic directional information and reduced target visibility during decomposition. To address these challenges, this study introduces a Sparse Differential Directionality prior (SDD) framework. SDD leverages the distinct directional characteristics of targets to differentiate them from the background, applying mixed sparse constraints on the differential directional images and continuity difference matrix of the temporal component, both derived from Tucker decomposition. We further enhance target detectability with a saliency coherence strategy that intensifies target contrast against the background during hierarchical decomposition. A Proximal Alternating Minimizationbased (PAM) algorithm efficiently solves our proposed model. Experimental results on several real-world datasets validate our method’s effectiveness, outperforming ten state-of-the-art methods in target detection and clutter suppression.

## SDD model
![system_diagramv5](https://github.com/user-attachments/assets/b4234f70-b4d4-4b6b-b1a2-13293997b019)

## Requirements
- **Matlab 2016 version or higher**

## Getting Started

**To run the SDD model, follow these steps:
1. Ensure you have MATLAB installed on your system.
2. Clone this repository to your local machine or download the files.
3. Open MATLAB and navigate to the directory where you saved the files.
4. Run the `IRDS_Code.m` file.

This will execute the SDD model with the default parameters and data.

**

## Data and Usage

The experimental images and data used in this model are part of the research conducted at public dataset  provided by National University of Defense Technology. Please ensure appropriate usage and citation if you are utilizing this model for academic or research purposes.

## Acknowledgements

The code provided in this repository are the property of Henan University of Technology, School of Information Science and Engineering. Unauthorized distribution, modification, or commercial use is strictly prohibited.


## Citation
```
I'll give it later
```
