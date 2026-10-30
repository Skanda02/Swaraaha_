#import "../lib.typ": *
#import "../meta.typ": *

// --- Chapter 4: System Implementation ---
#chapter_heading[SYSTEM IMPLEMENTATION]

== INTRODUCTION

The system implementation process is a multifaceted endeavor focused on developing a robust software architecture capable of effectively managing diverse user interactions, data processing tasks, and model inference operations.
By employing meticulous design and coding practices, the implementation ensures that the application is scalable, reliable, and secure, capable of handling varying workloads and protecting sensitive data.
Iterative testing and debugging procedures are integral components of the implementation process, allowing for the identification and resolution of any issues or bugs that may arise.
This iterative approach ensures that the application delivers a seamless user experience, free from disruptions or errors.
Additionally, post-deployment monitoring and maintenance mechanisms are established to continually assess system performance and address evolving requirements.
This ongoing maintenance ensures that the system remains optimized and responsive to user needs, even as conditions change over time, thereby facilitating long-term success and user satisfaction.

== ALGORITHM
The inference process follows a fixed sequence of steps that turns raw speech input into a complete, annotated analysis result.

- Step 1, Input Acquisition: the system acquires speech input either through real-time recording or by uploading an audio file.
- Step 2, Audio Conversion: the input audio is converted into a 16 kHz mono WAV format using FFmpeg to maintain consistency across all inputs.
- Step 3, Preprocessing: the audio is cleaned by removing the DC offset, applying peak normalization to a target amplitude, and trimming silent segments.
- Step 4, Length Normalization: the processed audio is adjusted to a fixed length of 48,000 samples (three seconds at 16 kHz) by padding or truncating as required.
- Step 5, Parallel Processing: the system processes the audio simultaneously through three independent branches:
  + Classification: Wav2Vec 2.0 embeddings are generated and passed through five binary classifiers, one per dysfluency type, and the outputs are aggregated into a multi-label result with a probability score for each dysfluency type.
  + Transcription: the Whisper model generates a timestamped transcript of the speech in English, Kannada, or Hindi.
  + Localization: the Wav2Vec2 frame-level localizer identifies the frame-level regions within the audio where dysfluencies occur.
- Step 6, Alignment: the detected dysfluency regions are mapped to the corresponding words or syllables in the transcript using CTC-based time alignment.
- Step 7, Combination and Severity: the combiner labels each localized region with per-class saliency scores from the classifier and fuses the classification and localization views, and the severity module computes a stutter index from the ratio of dysfluent speech duration to total speech duration.
- Step 8, Visualization and Report Generation: the system displays the results through waveform overlays, spectrograms, transcripts, and confidence scores, and generates a detailed clinical-style report.

== IMPLEMENTATION REQUIREMENTS

This section presents the implementation requirements for detecting and localizing stuttering with a hybrid deep learning model that combines Wav2Vec 2.0 feature extraction, five independent Wav2Vec 2.0 binary classifiers, a Wav2Vec2 frame-level localizer, and Whisper automatic speech recognition.
The main objective is to build a reliable, efficient system that identifies speech dysfluencies and localizes them within the audio.
The hybrid model uses the strengths of both architectures: Wav2Vec 2.0 supplies self-supervised, contextual speech representations that capture fine-grained phonetic and prosodic patterns, while Whisper provides sequence-level transcription that helps map localized dysfluency regions to specific words and syllables.

The implementation uses the Python ecosystem, which provides an interactive environment for model development, experimentation, and analysis.
Python serves as the primary language for backend development because of its versatility and its support for a wide range of scientific and deep learning libraries such as PyTorch, the Hugging Face Transformers library, and NumPy, which help with model construction, training, and evaluation.
For the frontend, React 19 and PySide6 build a user-friendly web interface and desktop application where users can record or upload speech audio and view classification and localization results.
All trained models are managed by a centralized model registry configured through a `registry.json` file that maps each task to its checkpoint and per-class thresholds, so checkpoints can be updated or replaced without changing application code.
The Python ecosystem also facilitates matrix manipulation, data visualization, algorithm implementation, and seamless integration with other programming environments, making it an ideal platform for developing and testing the hybrid model for stuttering classification and localization.

=== Train the Model

Training is a key step in developing the system for stutter classification and localization.
The speech audio dataset is first collected from Project Boli, SEP-28K, and UCLASS, then preprocessed through conversion to 16 kHz mono WAV, DC offset removal, peak normalization, silence trimming, and fixed-length padding, with data augmentation to improve audio quality and reduce overfitting.
The Wav2Vec 2.0 model is then trained to extract high-level contextual speech features, using its self-supervised pretraining to learn robust representations.
To improve classification accuracy further, the hybrid model combines five independent Wav2Vec 2.0 binary classifiers with a Wav2Vec2 frame-level localizer.
The localizer captures fine-grained temporal features at the frame level, complementing the broader segment-level extraction of the classifiers.
CTC-based time alignment then fuses the outputs of both models into one feature representation.
Training uses the AdamW optimizer to adjust learning rates adaptively and keep convergence stable.
It also uses mini-batches of audio, and backpropagation updates the weights from the computed loss.
Validation runs periodically to monitor accuracy and prevent overfitting.
After training, the optimized parameters and weights are saved, so the models can predict on new speech audio without retraining.

=== Test the Model

Testing happens after training to evaluate how well the proposed model detects stutter events in unseen speech audio.
When a user records or uploads a sample through the web interface or desktop application, it goes through the same preprocessing used in training: conversion to 16 kHz mono WAV, DC offset removal, peak normalization, silence trimming, and fixed-length padding. This keeps the input uniform for accurate analysis.
The trained Wav2Vec 2.0 model then extracts high-level contextual speech features.
For higher accuracy, the audio also runs through the hybrid model that combines five independent Wav2Vec 2.0 binary classifiers with a Wav2Vec2 frame-level localizer, which captures both segment-level dysfluency patterns and fine temporal detail.
CTC-based time alignment fuses the features from both models into one representation. The final aggregation layer then produces a classification result that names the dysfluency types present (blocks, prolongations, sound repetitions, word repetitions, or interjections) and the precise regions involved.
The interface shows the outcome with waveform overlays, spectrograms, a timestamped transcript, and confidence scores.
The model's predictions are also compared with ground truth labels to measure accuracy and generalization.
This phase confirms that the hybrid model performs well on new and unseen samples, which points to reliable stutter classification and localization in real clinical use.

=== Model Evaluation
Model evaluation is essential for assessing the overall performance and reliability of the proposed system.
Once the models are trained and tested, several quantitative metrics measure their classification performance:

- Accuracy: measures the proportion of correctly predicted samples.
- Precision: the share of predicted positive instances that are actually positive.
- Recall (Sensitivity): measures how effectively the model identifies all relevant positive samples.
- F1-Score: provides a harmonic mean of precision and recall to balance both metrics.

The five Wav2Vec 2.0 binary classifiers, one per dysfluency type, are further measured with AUROC (Area Under the Receiver Operating Characteristic Curve), AUPRC (Area Under the Precision-Recall Curve), and specificity, summarized per class and as a macro average across the five dysfluency classes.
The Wav2Vec2 frame-level localizer is measured with frame-level precision, recall, and F1, detection accuracy, mean Intersection over Union (IoU) between predicted and ground-truth regions, and the false alarm rate per minute.

A confusion matrix for each of the five binary classifiers shows the distribution of predictions, including true positives, false positives, true negatives, and false negatives.
This evaluation shows the strengths and weaknesses of each class; interjections, for example, are detected most reliably, while blocks are the hardest.

All reported results use the held-out test set of 3,715 clips, which is never touched during training or threshold selection, together with a cross-corpus Boli set that checks how well the models transfer to unseen speakers.

== USER INTERFACE
The web-based interface connects the user to the proposed stutter detection and localization system.
Users record speech or upload audio files for analysis.
Once audio is provided, the backend system carries out the preprocessing steps, followed by feature extraction, classification, transcription, and localization using the trained models.
Initially, the Wav2Vec 2.0 model is used to extract high-level contextual speech features, and to achieve higher accuracy, the hybrid pipeline combining five independent Wav2Vec 2.0 binary classifiers with the Wav2Vec2 frame-level localizer is employed.
Within a few seconds, the system presents the predicted result on the screen for each of the five dysfluency types, along with confidence scores, the localized regions, and the timestamped transcript.
The tool is designed for clinicians, speech-language pathologists, researchers, and individuals who stutter.

The system provides two interfaces to the same analysis pipeline: a web application and a desktop application.
The web frontend is built with React 19, TypeScript, and Tailwind CSS, with a sidebar layout covering the input page, results page, history, and reading passages.
The input page supports audio file upload (WAV, MP3, FLAC, M4A, OGG, WMA) and direct microphone recording through the MediaRecorder API, with client-side validation before the file is sent to the backend as multipart form data.
The results page shows classification results with confidence scores, an interactive waveform with color-coded dysfluency region overlays, a timestamped transcript, and a button to generate and download a PDF report.
The backend runs on FastAPI served through Uvicorn, exposing the `/api/classify`, `/api/localize`, `/api/analyze`, and `/api/report` endpoints.
Assessment history stays in the browser: audio files go into IndexedDB for offline access and analysis metadata into localStorage.

The desktop application is built with PySide6 (Qt for Python) for a native cross-platform interface.
It includes modules for audio recording and playback (sounddevice), file handling (soundfile), and model inference, calling the shared model package directly with no separate server, so it works fully offline.
PDF report generation uses Typst with pypdfium2 for viewing.

Both interfaces share the same model package, preprocessing conventions, and result schema, so a recording analysed in the browser and the same recording analysed on the desktop produce identical predictions and reports.
The web client keeps long-running requests responsive by streaming progress updates and disabling duplicate submissions while an analysis is in flight, while the desktop client runs inference in a worker thread so the window stays interactive during transcription and localization.
Theme switching, keyboard navigation, and consistent layout across window sizes are handled at the component level, which keeps the interface usable for clinicians who move between machines and screen sizes.
Uploaded audio is validated on the client before it reaches the backend, and the results view keeps the waveform, transcript, and per-class confidence table in sync so that selecting a timestamp jumps to the corresponding part of the recording.
Report generation is deliberately decoupled from analysis: the stored result payload is sufficient to rebuild the PDF, which means a report can be regenerated with a different layout or header without repeating the expensive model inference.
This shared design also simplifies maintenance, because a change to the result schema or the report template propagates to both interfaces from a single source rather than being reimplemented twice.

#pagebreak()