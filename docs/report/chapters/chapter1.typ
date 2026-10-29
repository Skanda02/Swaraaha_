#import "../lib.typ": *

// --- Chapter 1: Introduction ---
#chapter_heading[INTRODUCTION]

== INTRODUCTION TO THE PROJECT
Speech fluency lets a person express thoughts and feelings clearly.
Stuttering is a common speech disorder that interrupts speech production with involuntary repetitions, prolongations, or blocks.
It affects people of all ages, and it can wear down confidence and make communication and social interactions harder.
Spotting stuttering patterns early makes therapy and management easier.

Detection and assessment usually depend on speech-language pathologists watching and listening manually.
Results can be subjective, slow, and inconsistent from one expert to another, and the work is physically tiring.
That reliance on human evaluation makes large-scale assessment and continuous monitoring difficult.
Recent advances in deep learning and speech signal processing have made automated stutter detection a reliable alternative that can scale.
This project builds a system that detects, classifies, and analyzes stuttering types (prolongation, block, sound repetition, word repetition, and interjection) using deep learning.

Input audio is preprocessed and converted into embeddings, then analyzed with Wav2Vec 2.0, which captures local acoustic patterns and longer-range temporal dependencies that separate normal from dysfluent speech.
Alongside classification, a localization module returns timestamps for the stuttering events.
Those timestamps are hard-aligned with the transcript timestamps, so the system flags only the affected speech segments.
The finished model sits behind a simple interface where users record or upload speech samples and get an analysis with timestamped detections and classification output.

The project aims to give speech-language pathologists and people who stutter an accurate, objective, and accessible diagnostic tool.
The system also contributes to the growing use of artificial intelligence in healthcare, supporting diagnosis, therapy, and an improved quality of life for people who stutter.

== PROPOSED METHOD
The proposed method aims to develop an efficient deep learning-based system for the early detection and classification of speech dysfluencies from audio recordings.
The process begins with comprehensive audio preprocessing that includes noise reduction, normalization, and enhancement of acoustic clarity across all samples.
Segmentation isolates the meaningful regions of speech, eliminating irrelevant silence and background, and data augmentation such as noise injection, time and pitch shifting, and scaling simulates variations in speaking rate and recording conditions.
The system accurately categorizes the input into five dysfluency types: prolongation, block, sound repetition, word repetition, and interjection, and localizes the segments where these occur, supporting early diagnosis and effective treatment planning.
This automated approach reduces manual workload, minimizes observer bias, and enhances diagnostic reliability, making it a valuable tool in computer-aided speech assessment.

== LITERATURE SURVEY
#include "/contents/literature_survey.typ"

== PROBLEM STATEMENT

Stuttering assessment in clinical practice still depends heavily on manual observation, where a speech-language pathologist listens to recordings and marks dysfluencies by hand. This process is slow, subjective, and difficult to reproduce, and the disagreement between raters makes it hard to track a patient's progress reliably. Existing automated tools mostly stop at binary detection, reporting that a recording contains stuttering without indicating which type occurred or where in the audio it occurred, which limits their usefulness for therapy planning.

The problem addressed in this project is therefore to build a single pipeline that takes an unconstrained speech recording and produces a structured analysis: whether stuttering is present, which of the five dysfluency types are involved, and the exact time regions where each event occurs. The system must also remain usable without large annotated corpora from the target speaker and must run fast enough to support interactive assessment rather than offline batch processing.

== OBJECTIVES

The project is organized around four objectives, each contributing one stage of the final pipeline.

+ *Speech preprocessing:* clean and standardize the input audio so that every downstream model receives consistent data. This covers resampling to a fixed rate, DC offset removal, peak normalization, silence trimming, fixed-length padding, and augmentation such as noise injection and time or pitch shifting, which together reduce the effect of varying recording conditions and speaker loudness.

+ *Stutter detection:* decide whether a given speech sample contains dysfluent speech at all. The output is a binary signal that gates the rest of the analysis, so the model is trained to hold up across speakers, languages, and background noise, not only on clean studio recordings.

+ *Stutter classification:* identify which dysfluency types are present among prolongation, block, sound repetition, word repetition, and interjection. Because these events often co-occur, the system decides each type independently and gives it its own confidence score rather than forcing one mutually exclusive label.

+ *Stutter localization:* find the time regions in the waveform where the detected events occur and align them with the corresponding words in the transcript. That gives clinicians usable timestamps, so they can go straight to the affected segment and compare the detected events with what was said.

The objectives are ordered so each stage builds on the one before it. Preprocessing produces a normalized waveform and spectrogram for the detection and classification models. Detection then narrows the analysis to samples that contain dysfluencies. Classification assigns type-level scores to those samples, and localization maps the detected events back onto the time axis and the transcript.



#pagebreak()