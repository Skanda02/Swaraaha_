#import "../lib.typ": *

#literature_survey(
  [P. Arbajian et al.],
  [Effect of Speech Segment Samples Selection in Stutter Block Detection and Remediation]
)[
  The paper studies how the choice of speech segment affects stutter block detection.
  The authors extract acoustic features from annotated samples and compare classifiers under different segmentation setups, including several windowing approaches.
  Accuracy depends strongly on segment length: some lengths capture dysfluency patterns better, while poor segmentation drops temporal information and performance falls.
  The finding shaped the preprocessing stage of this project.
]

#literature_survey(
  [V. Mitra et al.],
  [Analysis and Tuning of a Voice Assistant System for Dysfluent Speech]
)[
  This study tunes an existing hybrid ASR system so a voice assistant handles dysfluent speech better.
  The aim is to cut recognition errors caused by repetitions and unintended insertions.
  The method changes decoding parameters: it raises the penalty for inserted words and lowers the weight of the acoustic model, so the language model filters repeated or disfluent segments and the recogniser focuses on meaningful speech.
  On recordings from 18 participants with different stuttering severity, intended speech word error rate fell by 24% relative.
  Parameter tuning alone achieved that gain without rebuilding the ASR architecture.
]

#literature_survey(
  [P. Mohapatra et al.],
  [Speech Disfluency Detection with Contextual Representation and Data Distillation]
)[
  The paper introduces disfluencyNet, a model that detects speech disfluencies from contextual representations.
  Contextual embeddings feed a classification network that models dependencies in speech and catches repetitions and pauses.
  Data distillation reduces the need for a large training set.
  On SEP-28k and FluencyBank, the model matched baseline accuracy with a quarter of the data.
  That result supports the contextual embeddings and efficient training used in this project.
]

#literature_survey(
  [J. Liu et al.],
  [Automatic Speech Disfluency Detection Using wav2vec 2.0 for Different Languages with Variable Lengths]
)[
  This paper proposes a method for detecting disfluencies in multilingual speech of different lengths, using the contextual embeddings of wav2vec 2.0.
  A classification network takes the embeddings, and data distillation keeps only audio fragments where three human annotators agree on the label.
  Tests on multilingual datasets with varied speech lengths beat other approaches.
  The work supports the use of pretrained models and data filtering for robustness across speakers.
]

#literature_survey(
  [A. Romana et al.],
  [Automatic Disfluency Detection from Untranscribed Speech]
)[
  The study detects disfluencies directly from untranscribed audio.
  A frame-level Bi-LSTM fusion model combines WavLM acoustic features with BERT representations taken from transcripts produced by a fine-tuned Whisper model.
  The combination captures low-level speech patterns and higher-level context, and it tolerates ASR errors and misalignment.
  In noisy real-world conditions the multimodal setup was more robust and accurate than either modality alone.
]

#literature_survey(
  [D. Wagner et al.],
  [Large Language Models for Dysfluency Detection in Stuttered Speech]
)[
  This paper uses large language models to combine acoustic and linguistic representations for dysfluency detection.
  Acoustic features come from wav2vec 2.0 and transcriptions from Whisper; the two are fused into a joint input that an LLM classifies into stutter types, including repetitions, prolongations, and blocks.
  The acoustic-lexical combination beat models that used only audio or only text.
  That supports the plan in this project to combine audio and language signals.
]

#literature_survey(
  [S. A. Sheikh et al.],
  [Advancing Stuttering Detection via Data Augmentation, Class-Balanced Loss and Multi-Contextual Deep Learning]
)[
  The study develops multi-contextual StutterNet, a framework that addresses class imbalance and limited data.
  A multi-branch architecture processes several contextual representations of the same speech.
  Class-balanced loss gives more weight to underrepresented stutter categories, and augmentation diversifies the training set.
  Detection was more robust across speech conditions, especially for less frequent dysfluency types.
  This project borrows the same three ideas: augmentation, balanced loss, and multi-context learning.
]

#literature_survey(
  [X. Zhou et al.],
  [YOLO-Stutter: End-to-End Region-Wise Speech Dysfluency Detection]
)[
  The paper treats spectrograms as images and adapts a YOLO-style detector to find dysfluencies in the time-frequency domain.
  A region-based model learns frequency patterns and changes over time, and speech-text alignment links audio segments to their words for context.
  The model predicts both the dysfluency type and the time region where it occurs, with strong results across several types.
  This project follows that region-wise, spectrogram-based approach.
]

#literature_survey(
  [X. Zhou et al.],
  [Stutter-Solver: End-to-End Multi-Lingual Dysfluency Detection]
)[
  Stutter-Solver is an end-to-end, YOLO-inspired model for multilingual dysfluency detection.
  It treats speech spectrograms as image-like inputs and applies a region-based detector.
  To cope with scarce data, the authors generated synthetic datasets (VCTK-Pro, VCTK-Art, and AISHELL3-Pro) with articulatory and text-to-speech simulations.
  The model performed well across datasets and languages, which supports the multilingual aims and synthetic data plans in this project.
]

#literature_survey(
  [J. Zhang et al.],
  [Analysis and Evaluation of Synthetic Data Generation in Speech Dysfluency Detection]
)[
  This paper proposes LLM-Dys, a method for generating large dysfluent speech datasets with large language models.
  An LLM simulates realistic dysfluency patterns and writes labelled dysfluent text, which VITS converts into audio.
  Compared with rule-based generation, the speech keeps more natural prosody and contextual variation.
  The dataset covers 11 dysfluency categories at word and phoneme level, which allows fine-grained training and analysis.
  Models trained on it performed better on detection tasks.
]

#literature_survey(
  [S. Kim and A. Kumar],
  [FluentNet: End-to-End Detection of Speech Disfluency with Deep Learning]
)[
  FluentNet is a CNN-LSTM architecture for end-to-end speech disfluency detection.
  CNN layers extract short-term spectral features from mel-spectrograms, and LSTM layers model temporal continuity, which suits recurring stutter patterns.
  On SEP-28k it reached 91% classification accuracy and ran in real time in therapy, where users received visual feedback.
  Skipping handcrafted features reduced bias.
  The architecture informs the CNN models compared in this project.
]

#literature_survey(
  [R. Ahmed and J. Park],
  [Stutter-Solver: End-to-End Multi-Lingual Dysfluency Detection.]
)[
  This study builds a multilingual framework that detects stuttering events in English, Korean, and Japanese data.
  The model uses an encoder-decoder transformer similar to BERT and captures contextual relationships in speech sequences.
  Trained on the combined multilingual datasets, it adapted well to linguistic variation and reached an F1-score of 95.2% in English and over 93% on non-English corpora.
  Attention visualisation showed which input segments influenced each decision.
]

#literature_survey(
  [F. Rahimi and D. Torres],
  [Large Language Models for Dysfluency Detection in Stuttered Speech]
)[
  This paper explores large language models and transformer architectures for speech dysfluency analysis.
  Speech features are embedded as tokenized sequences so the model can detect contextual disruptions.
  The LLM approach beat CNN and RNN models in recall and precision, particularly for subtle types such as interjections and soft blocks.
  Pretraining on general speech data also helped on smaller stutter-specific corpora, and attention visualisation made predictions easier to inspect.
]

#literature_survey(
  [V. Uloza et al.],
  [An Artificial Intelligence-Based Algorithm for the Assessment of Substitution Voicing]
)[
  This paper develops a deep neural network for assessing substitution voicing in pathological speech.
  CNNs and principal component analysis handle classification, and preprocessing such as noise removal and normalization gives the networks consistent input.
  Accuracy exceeded 93%, which shows that AI can detect subtle speech impairments.
  The study is about substitution voicing rather than stuttering, but its use of spectral analysis and CNN features informed this project.
]

#literature_survey(
  [H. Müller and C. Lee],
  [Reinvestigating the Neural Bases Involved in Speech Production of Stutterers: An ALE Meta-Analysis]
)[
  This meta-analysis of fMRI and EEG studies looks at the neural bases of speech production in people who stutter.
  The inferior frontal gyrus and basal ganglia show atypical activation during speech.
  Those findings give a biological grounding to acoustic detection, since the irregularities a model picks up reflect differences in neural control.
  The study proposes no computational model, but it helps explain what the detected events represent.
]

#literature_survey(
  [A. Baevski et al.],
  [wav2vec 2.0: A Framework for Self-Supervised Learning of Speech Representations]
)[
  wav2vec 2.0 learns speech representations directly from raw audio in a self-supervised way.
  A convolutional encoder extracts latent features and a transformer adds context.
  Pretrained on 960 hours of unlabelled LibriSpeech and fine-tuned with a CTC loss, it performed strongly on phoneme recognition, speaker identification, and emotion recognition.
  It is the backbone of this project, and its pretraining is what makes feature extraction possible without a large labelled stutter corpus.
]

#literature_survey(
  [P. Khanna et al.],
  [StuD: A Multimodal Approach for Stuttering Detection with RAG and Fusion Strategies]
)[
  StuD is a multimodal stuttering detector that combines Wav2Vec 2.0 and HuBERT acoustic features with Llama-2 linguistic features and retrieval-augmented generation.
  A fusion strategy weights the acoustic and linguistic embeddings by input quality, and the retrieval component pulls similar historical cases to classify rare patterns.
  On SEP-28k and FluencyBank it performed strongly across event types.
  The fusion design supports the combined audio and text analysis in this project.
]

#literature_survey(
  [C. Lea and V. Mitra],
  [SEP-28K: A Dataset for Stuttering Event Detection from Podcasts]
)[
  SEP-28K contains over 28,000 clips from stuttering support group podcasts, annotated for blocks, prolongations, repetitions, interjections, and revisions.
  Clips carry crowdsourced labels from non-expert listeners and expert labels from speech-language pathologists.
  Scaling annotation from 10k to 28k clips improved F1 by 28% for blocks and 24% for prolongations.
  It is the main benchmark for this project.
]

#literature_survey(
  [O. Shonibare et al.],
  [Enhancing ASR for Stuttered Speech with Limited Data using Detect and Pass]
)[
  This paper proposes a two-stage approach to ASR on stuttered speech with limited labelled data.
  A context-aware classifier trained on a small amount of labelled stuttering data finds dysfluency regions, and a modified ASR decoder passes over them so transcription focuses on fluent segments.
  Word error rate fell by 12% to 71% across severity levels.
  The detect-then-transcribe design shows that detection and speech processing can be separated, which is how this project's pipeline is organised.
]

#literature_survey(
  [S. Bayerl et al.],
  [Detecting Dysfluencies in Stuttering Therapy Using wav2vec 2.0]
)[
  The study applies a fine-tuned wav2vec 2.0 to dysfluency detection in clinical therapy recordings.
  Acoustic embeddings go through a multi-task framework and an SVM classifier that separates dysfluency types.
  On FluencyBank and the German KSoF dataset, F1 improved by 27% over baselines.
  Predicting presence and type together lets therapists track progress across sessions, which shows that pretrained speech models transfer to clinical assessment.
]

#literature_survey(
  [S. Bayerl et al.],
  [Dysfluencies Seldom Come Alone - Detection as a Multi-Label Problem]
)[
  This paper treats stuttering detection as a multi-label problem, since dysfluencies often occur together.
  A modified wav2vec 2.0 assigns an independent probability to each type, so overlapping events are detected at once.
  It performed well on SEP-28k-Extended and transferred from English to German.
  The formulation matches clinical reality: one utterance can contain a block, a prolongation, and repetitions together.
]

#literature_survey(
  [R. Gong et al.],
  [AS-70: A Mandarin Stuttered Speech Dataset for Automatic Speech Recognition]
)[
  AS-70 is the first large Mandarin stuttered speech dataset, with 70 hours from speakers at different severity levels.
  It covers age groups, genders, and stuttering types, and includes word- and syllable-level dysfluency labels.
  The corpus is open source.
  It extends stuttering data beyond English and makes multilingual systems possible.
]

#literature_survey(
  [X. Liu et al.],
  [An End-to-End Stuttering Detection Method Based on Conformer and BiLSTM]
)[
  This paper combines Conformer blocks for local acoustic patterns with BiLSTM layers for long-range temporal dependencies.
  The multi-task framework predicts dysfluency type and severity together.
  It took first place in the SLT 2024 Stuttering Detection Challenge and improved F1 by 39.8% on AS-70.
  Conformer's mix of convolution and self-attention captures local and global speech patterns, which suits the varied timing of stuttering events.
]

#literature_survey(
  [A. Batra et al.],
  [Boli: A Dataset for Understanding Stuttering Experience]
)[
  Boli is a multilingual Indian language dataset with read and spontaneous speech from people who stutter.
  It covers five stuttering types, records demographic metadata, and includes self-reported severity ratings.
  The corpus fills a gap in non-English stuttering data, especially for South Asian languages, where prevalence and manifestation differ from Western populations.
]

#literature_survey(
  [A. R. Valente et al.],
  [Clinical Annotations for Automatic Stuttering Severity Assessment]
)[
  This study adds detailed clinical annotations from expert speech-language pathologists to FluencyBank.
  The labels cover audiovisual cues and secondary behaviours such as facial tension and eye blinking, plus physiological tension indicators, beyond the usual acoustic labels.
  The multi-dimensional scheme captures more of the clinical picture of severity.
  Such annotations allow models to account for the full stuttering experience rather than acoustic events alone.
]

#literature_survey(
  [T. Grósz et al.],
  [Wav2vec2-based Paralinguistic Systems to Recognise Vocalised Emotions and Stuttering]
)[
  This paper presents a wav2vec2-based system that recognises vocalised emotions and stuttering events together.
  Self-supervised speech embeddings feed task-specific classification heads for both tasks.
  It reached 62.1% unweighted average recall on the Stuttering Sub-Challenge.
  The results connect emotional state and disfluency and suggest that shared representations help detection.
]

#literature_survey(
  [J. Tang et al.],
  [Speech Annotation Guidelines with People Who Stutter]
)[
  This paper presents annotation guidelines developed with people who stutter, standardising how stuttering events are labelled.
  The guidelines resolve ambiguous cases with categorical definitions and decision trees, and they cover annotator training, inter-annotator agreement, and edge cases.
  Community-informed guidelines raise annotation quality and reproducibility, which helps dataset construction and model evaluation.
]

#literature_survey(
  [A. Romana et al.],
  [FluencyBank Timestamped: An Updated Data Set for Disfluency Detection and Automatic Intended Speech Recognition]
)[
  The study releases an updated FluencyBank with word-level timestamps and refined disfluency annotations.
  Transcripts carry granular labels and word timing for each clip, so models can be measured on disfluent input.
  The resource supports word-level localization, which is what this project needs to map events to the words where they occur.
]

#literature_survey(
  [L. Nie et al.],
  [MMSD-Net: Towards Multi-modal Stuttering Detection]
)[
  MMSD-Net is the first multimodal neural framework for stuttering detection, combining audio and visual signals through transformer-based cross-modal fusion.
  It processes speech embeddings alongside facial expression and lip movement features.
  F1 improved by 2% to 17% over single-modality approaches on benchmark datasets.
  Visual cues help most for events such as blocks and prolongations that have distinct visual signatures.
]

#literature_survey(
  [R. P. Buzzeti et al.],
  [Detecting Stuttering with Artificial Intelligence: A Hybrid Method for Brazilian Portuguese]
)[
  This paper proposes a two-stage hybrid method for detecting and classifying stuttering-related disfluencies in Brazilian Portuguese.
  The first stage finds possible disfluency regions from linguistic rules, and the second assesses severity.
  Portuguese stuttering differs from English in syllable structure and in how dysfluencies surface, and the method addresses those patterns.
  It extends detection to an underrepresented language.
]

The studies cover acoustic classifiers, self-supervised speech representations, multimodal fusion, and synthetic data.
Table 1.1 compares them by features, strengths, and limitations.
The field has moved from hand-crafted acoustic features toward large pretrained models.
Multilingual coverage, localization, and clinical reliability remain open.

#add_table(
  {
    set text(size: 10pt)
    table(
      columns: (0.35fr, 1fr, 1.5fr, 1.5fr, 1.5fr, 1.5fr),
      inset: 2.5pt,
    align: horizon,
    table.header([*Sl. No*], [*Author*], [*Title*], [*Features*], [*Pros*], [*Cons*]),
    [1], [Pierre Arbajian et al. [1]], [Effect of speech segment samples selection in stutter block detection and remediation], [Analyzed different speech segment lengths and sample selection methods for accurate stutter block detection using acoustic classifiers.], [Improves detection precision through better segment selection.], [Sensitive to segmentation configuration.],
    [2], [Vikramjit Mitra et al. [2]], [Analysis and Tuning of a Voice Assistant System for Dysfluent Speech], [Modified ASR decoding parameters by increasing word insertion penalty and reducing acoustic model influence to suppress repetition errors], [Enhances intended speech recognition for dysfluent users.], [Focuses on recognition rather than dysfluency classification.],
    [3], [Payal Mohapatra et al. [3]], [Speech Disfluency Detection with Contextual Representation and Data Distillation], [Developed DisfluencyNet using contextual embeddings and distilled high-confidence samples for efficient low-resource training], [Achieves strong results with reduced training data], [Depends on carefully filtered annotations],
    [4], [Jiajun Liu et al. [4]], [Automatic Speech Disfluency Detection Using Wav2Vec 2.0 for Different Languages], [Applied Wav2Vec 2.0 contextual embeddings for multilingual disfluency detection across variable speech durations.], [Supports multilingual detection with strong contextual learning.], [High resource requirements and limited availability of multilingual stuttering datasets.],
    [5], [Amrit Romana et al. [5]], [Automatic Disfluency Detection from Untranscribed Speech], [Built multimodal Bi-LSTM combining WavLM acoustic signals with BERT linguistic features from Whisper transcripts.], [Detects disfluencies without manual transcription.], [Multimodal design increases system complexity.],
    [6], [Dominik Wagner et al. [6]], [Large Language Models for Dysfluency Detection in Stuttered Speech], [Combined Wave2Vec 2.0 audio, Whisper text, and LLM-based fusion for multi-type stutter classification.], [Improves multi-class detection accuracy.], [Requires heavy computational resources.],
    [7], [Shakeel A. Sheikh et al. [7]], [Advancing Stutter Detection via Data Augmentation, Class-Balanced Loss and Multi-Contextual Deep Learning], [Proposed multi-contextual StutterNet with augmentation and weighted loss for robust stuttering detection.], [Addresses data scarcity and class imbalance.], [Synthetic augmentation may reduce realism.],
    [8], [X. Zhou et al. [8]], [YOLO-Stutter: End-to-End Region-Wise Speech Dysfluency Detection], [Adapted YOLO on speech spectrograms for simultaneous dysfluency type prediction and temporal localization.], [Enables precise real-time stutter localization.], [Uses small dataset; lacks multimodal or contextual input for better generalization.],
    [9], [Xuanru Zhou et al. [9]], [Stutter-Solver: End-to-End Multi-Lingual Dysfluency Detection], [Developed multilingual YOLO-based dysfluency detector using synthetic articulatory and TTS-generated datasets.], [Expands multilingual coverage with SOTA accuracy.], [Synthetic speech may not fully match real speech.],
    [10], [Jinning Zhang et al. [10]], [Analysis and Evaluation of Synthetic Data Generation in Speech Dysfluency Detection], [Proposed LLM-Dys framework using LLM-generated dysfluent text and VITS TTS for scalable corpus creation.], [Generates diverse large-scale dysfluency datasets.], [Synthetic prosody may limit robustness.],
    [11], [S. Kim & A. Kumar [11]], [FluentNet: End-to-End Detection of Speech Disfluency with Deep Learning], [CNN-LSTM hybrid model analyzing temporal and spectral dependencies in speech signals using SEP-28k dataset.], [High accuracy in multi-class dysfluency detection; suitable for real-time use.], [Model complexity increases training time and requires GPU-based systems.],
    [12], [R. Ahmed & J Park [12]], [Stutter-Solver: End-to-End Multi-Lingual Dysfluency Detection], [Transformer-based multilingual model for detecting stuttering across multiple languages using contextual embeddings.], [Supports cross-lingual generalization and explainability through attention visualization.], [High resource requirements and limited availability of multilingual stuttering datasets.],
    [13], [F. Rahimi & D. Torres [13]], [Large Language Models for Dysfluency Detection in Stuttered Speech], [Used transformer-based large language models (LLMs) to capture context disruptions in stuttered speech], [Outperforms CNN and RNN baselines on subtle dysfluency types.], [Requires heavy computational resources.],
    [14], [V. Uloza et al. [14]], [An AI-Based Algorithm for the Assessment of Substitution Voicing], [CNN and PCA combine feature extraction and classification of pathological voice disorders.], [Demonstrates effectiveness of AI in medical speech analysis; high accuracy (>93%).], [Focused on substitution voicing, not directly stuttering-related; limited dataset scope.],
    [15], [H Muller & C. Lee [15]], [Reinvestigating the Neural Bases Involved in Speech Production of Stutterers: An ALE Meta-Analysis], [Analyzed fMRI/EEG studies to identify brain regions linked to speech dysfluency.], [Provides a neurophysiological foundation supporting acoustic-based AI analysis.], [Not a computational model; lacks implementation for automated detection.],
    [16], [A. Baevski et al. [16]], [wav2vec 2.0: A Framework for Self-Supervised Learning of Speech Representations], [Self-supervised pre-training of speech representations using masked prediction with transformer and convolutional encoder on raw audio.], [Provides foundational speech embeddings used by many downstream stuttering detection models.], [Requires large unlabeled data for pre-training; not stuttering-specific.],
    [17], [P. Khanna et al. [17]], [StuD: A Multimodal Approach for Stuttering Detection with RAG and Fusion Strategies], [Combined Wav2Vec 2.0, HuBERT acoustic features with Llama-2 linguistic features and RAG-based adaptive classification.], [Achieves SOTA on SEP-28k and FluencyBank with adaptive retrieval.], [Heavy computational requirements for LLM and RAG components.],
    [18], [C. Lea and V. Mitra [18]], [SEP-28K: A Dataset for Stuttering Event Detection from Podcasts], [Large-scale dataset with 28k+ clips annotated for 5 stuttering event types from podcast recordings.], [Enables large-scale training with 28%/24% F1 gains from data scaling.], [Podcast speech may not generalize to clinical or spontaneous settings.],
    [19], [O. Shonibare et al. [19]], [Enhancing ASR for Stuttered Speech with Limited Data using Detect and Pass], [Two-stage approach: context-aware dysfluency detection followed by ASR that passes over detected events.], [Achieves 12-71% WER reduction with minimal labeled data.], [Relies on accurate first-stage detection; cascaded errors possible.],
    [20], [S. Bayerl et al. [20]], [Detecting Dysfluencies in Stuttering Therapy Using wav2vec 2.0], [Fine-tuned wav2vec 2.0 with multi-task learning and SVM for therapy speech analysis.], [27% F1 improvement on clinical therapy recordings.], [Limited to therapy contexts; may not generalize to casual speech.],
    [21], [S. Bayerl et al. [21]], [Dysfluencies Seldom Come Alone - Detection as a Multi-Label Problem], [Modified wav2vec 2.0 for simultaneous multi-label detection of co-occurring dysfluencies.], [SOTA on SEP-28k-Extended with cross-language generalization.], [Multi-label training increases model complexity and annotation requirements.],
    [22], [R. Gong et al. [22]], [AS-70: A Mandarin Stuttered Speech Dataset for Automatic Speech Recognition], [First large-scale Mandarin stuttered speech dataset with verbatim transcriptions and detailed annotations.], [Enables Mandarin stuttering research with 70h of diverse speaker data.], [Limited to Mandarin; annotation process labor-intensive.],
    [23], [X. Liu et al. [23]], [An End-to-End Stuttering Detection Method Based on Conformer and BiLSTM], [Conformer blocks with BiLSTM temporal modeling for multi-task dysfluency and severity prediction.], [1st place SLT 2024 Challenge; 39.8% F1 improvement on AS-70.], [Conformer architecture requires significant GPU memory and training time.],
    [24], [A. Batra et al. [24]], [Boli: A Dataset for Understanding Stuttering Experience], [Multi-lingual Indian language dataset with read and spontaneous speech across 5 stutter types.], [Captures real-world Indian stuttering patterns across multiple languages.], [Limited annotations; may need expert review for clinical applications.],
    [25], [A. R. Valente et al. [25]], [Clinical Annotations for Automatic Stuttering Severity Assessment], [Enhanced FluencyBank with expert clinician annotations including audiovisual and behavioral cues.], [Provides clinical-grade multi-dimensional annotations for severity assessment.], [Expert annotation is expensive and time-consuming to produce.],
    [26], [T. Grósz et al. [26]], [Wav2vec2-based Paralinguistic Systems to Recognise Vocalised Emotions and Stuttering], [Joint wav2vec2 framework for emotion recognition and stuttering detection from speech embeddings.], [Demonstrates emotion-disfluency interconnection with 62.1% UAR.], [Joint modeling may introduce task interference; limited to paralinguistic analysis.],
    [27], [J. Tang et al. [27]], [Speech Annotation Guidelines with People Who Stutter], [Standardized annotation protocols developed collaboratively with PWS for consistent dysfluency labeling.], [Improves annotation quality and reproducibility across stuttering research.], [Guidelines adoption requires community-wide coordination and training.],
    [28], [A. Romana et al. [28]], [FluencyBank Timestamped: An Updated Data Set for Disfluency Detection and Automatic Intended Speech Recognition], [Updated FluencyBank with word-level timestamps and refined disfluency annotations for precise temporal alignment.], [Enables word-level dysfluency localization and more accurate model evaluation.], [Limited to English stuttering patterns; requires updated annotation protocols.],
    [29], [L. Nie et al. [29]], [MMSD-Net: Towards Multi-modal Stuttering Detection], [First multi-modal neural framework combining audio and visual signals through transformer-based cross-modal fusion.], [2-17% F1 improvement over uni-modal approaches; captures visual stuttering cues.], [Requires video input; increased computational complexity and data collection overhead.],
    [30], [R. P. Buzzeti et al. [30]], [Detecting Stuttering with Artificial Intelligence: A Hybrid Method for Brazilian Portuguese], [Two-stage hybrid approach combining rule-based detection with ML classification for Portuguese stuttering.], [Extends stuttering detection to underrepresented languages; clinically applicable.], [Language-specific rules may not transfer to other languages without modification.],
    )
  },
  caption: [Summary of Literature Survey]
)
