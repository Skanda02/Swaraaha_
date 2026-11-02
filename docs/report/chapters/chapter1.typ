#import "../lib.typ": *

// --- Chapter 1: Introduction ---
#chapter_heading[INTRODUCTION]

== INTRODUCTION TO THE PROJECT
Speech fluency lets a person express thoughts and feelings clearly.
Stuttering interrupts that flow with involuntary repetitions, prolongations, or blocks.
It affects people of all ages, and it can wear down confidence and make conversation and social contact harder.
Spotting the patterns early makes therapy and day-to-day management easier.

In practice, detection and assessment still depend on a speech-language pathologist who listens to recordings and marks what they hear.
Two clinicians can disagree about the same sample, the work is slow, and repeating it is tiring.
That dependence on human listening also makes large-scale assessment and continuous monitoring hard to organise.
Deep learning and speech signal processing now offer a scalable alternative.
This project builds a system that detects, classifies, and analyzes five stuttering types: prolongations, blocks, sound repetitions, word repetitions, and interjections.

The pipeline preprocesses input audio, converts it into embeddings, and analyzes it with Wav2Vec 2.0, which captures fine acoustic detail and dependencies across longer stretches of speech.
A second module localizes the stuttering events and returns their timestamps.
Those timestamps are aligned with the transcript, so the system flags only the affected segments.
The finished model sits behind a simple interface where a user records or uploads a sample and receives timestamped detections, class labels, and confidence scores.

The aim is an accurate, objective, and accessible diagnostic tool for speech-language pathologists and people who stutter.
The work also adds to the use of artificial intelligence in healthcare, where the same analysis can support diagnosis, therapy, and a better quality of life.

== PROPOSED METHOD
The proposed method is a deep learning system that detects and classifies speech dysfluencies early, using audio recordings as input.
Preprocessing removes noise, normalizes loudness, and sharpens acoustic detail across all samples.
Segmentation isolates the regions that carry speech so silence and background noise drop out.
Augmentation such as noise injection, time and pitch shifting, and amplitude scaling exposes the model to different speaking rates and recording conditions.
The system then assigns each input to one of five dysfluency types and marks where the event occurred, which supports early diagnosis and treatment planning.
Automating this work cuts manual effort, reduces observer bias, and makes the assessment more reliable.

== LITERATURE SURVEY
#include "/contents/literature_survey.typ"

== PROBLEM STATEMENT

Stuttering assessment in clinical practice still depends heavily on a speech-language pathologist who listens to recordings and marks dysfluencies by hand. The process is slow, subjective, and difficult to reproduce, and disagreement between raters makes a patient's progress hard to track. Most automated tools stop at binary detection: they report that a recording contains stuttering but not which type occurred or where in the audio it occurred, which limits their use for therapy planning.

This project addresses that gap with a single pipeline that takes an unconstrained speech recording and produces a structured analysis: whether stuttering is present, which of the five dysfluency types are involved, and the exact time regions where each event occurs. The system must also work without a large annotated corpus from the target speaker and must run fast enough for interactive assessment rather than offline batch processing.

== OBJECTIVES

The project is organised around four objectives, and each one supplies a stage of the final pipeline.

+ #block(breakable: false)[*Speech preprocessing:* clean and standardise the input audio so every downstream model receives consistent data. This covers resampling to a fixed rate, DC offset removal, peak normalization, silence trimming, fixed-length padding, and augmentation such as noise injection and time or pitch shifting, which together reduce the effect of varying recording conditions and speaker loudness.]

+ #block(breakable: false)[*Stutter detection:* decide whether a sample contains dysfluent speech at all. The binary output gates the rest of the analysis, so the model is trained to hold up across speakers, languages, and background noise, not only on clean studio recordings.]

+ #block(breakable: false)[*Stutter classification:* identify which dysfluency types are present among prolongation, block, sound repetition, word repetition, and interjection. Because these events often co-occur, the system decides each type independently and gives it its own confidence score rather than forcing one mutually exclusive label.]

+ #block(breakable: false)[*Stutter localization:* find the time regions where detected events occur and align them with the corresponding words in the transcript. Clinicians get usable timestamps, so they can go straight to the affected segment and compare the detected events with what was said.]

The objectives are ordered so each stage builds on the one before it. Preprocessing produces a normalized waveform and spectrogram for detection and classification. Detection narrows the analysis to samples that contain dysfluencies. Classification assigns type-level scores, and localization maps the events back onto the time axis and the transcript.
Together these stages turn a recording into evidence that can be inspected at clip level and at event level. The classification scores summarise what was detected, while the localized intervals and aligned transcript show where it happened, which makes the result easier to review.



#pagebreak()
