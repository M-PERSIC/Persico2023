#import "template.typ": *
#show: ieee.with(
  title: "MAFFT, Clustal-Omega, MUSCLE multiple sequence alignment program wrappers, and central BioJulia documentation page",
  abstract: [
    Progressive multiple sequence alignment methods are at the foundation of pillar sequencing workflows, enabling homology determination, wildlife trafficking analysis and additional use cases both in bioinformatics and in other fields. The BioAlignments.jl package currently lacks multiple sequence alignment capability, therefore the primary portion of the project would address generating official BioJulia wrappers for the MAFFT, Clustal Omega, and MUSCLE sequence alignment methods that could either be used separately or integrated into BioAlignments.jl or other BioJulia packages in the future. Another concern lies in the lack of a dedicated landing page with a comprehensive overview of the BioJulia ecosystem for both users and developers, hence a secondary objective to develop a global "BioJuliaDocs" BioJulia documentation page similar, in principle, to SciMLDocs. 
  ],
  authors: (
    (
      name: "Michael Alexander Persico",
      department: [Department of Biology],
      organization: [Concordia University],
      location: [Montreal, QC, Canada],
      timezone: "UTC/GMT -4 hours",
      email: "michael.persico@mail.concordia.ca",
      github: "github.com/M-PERSIC",
      linkedin: "linkedin.com/in/michael-persico/"
    ),
  ),
  index-terms: ("BioJulia", "Julia Summer of Code", "Google Summer of Code", "Multiple Sequence Alignment", "JLL", "Documentation"),
  bibliography-file: "refs.bib",
)

#set par(leading: 1em)
#let JulDate = [July]

= Introduction

I am a current Systems and Information Biology undergraduate student aiming to carry out my honours research thesis before graduating in December 2023. Previously, I had completed one year within the Université de Montréal's bioinformatics program before transferring to Concordia in Cell and Molecular Biology with a computer science minor before finally transferring internally to my current program. I have previously completed three work terms in molecular biology over the course of a one year period as part of my university's Co-op initiative. I had learned Julia for a bioinformatics project exploring Zstandard custom dictionary compression on FASTA-formatted data @github, and would be thrilled at the possibility of contributing to the BioJulia community with useful packages and other contributions both during and after the JSoC.

#pagebreak()

= Projects

== MAFFT, Clustal-Omega, MUSCLE wrappers

Arrangement and comparison between genetic sequences represents a fundamental process in workflows related to genetics, molecular biology, and other fields wherein the characterization of raw sequence data can serve a wide range of uses @chowdhury2017review. Sequence similarity assessment has allowed for phylogenetic reconstructions across whole life domains #cite("pearson2013introduction", "melnikov2018revising"), improving endangered species conservation efforts #cite("qiao2019population", "brandies2019value"), and even combating wildlife trafficking #cite("wasser2008combating", "dalton2020assessing"). A number of multiple sequence alignment (MSA) methods are available, each with unique advantages and limitations that must be weighed depending on the research context. Many current progressive MSA methods, including MAFFT, Clustal Omega, and MUSCLE, rely on the construction of a guide tree structure according to greedy iteration of enlarging alignments @boyce2014simple. There has seemingly been demand for a Julia API for such programs, evidenced by requests from users for such @githubbioissue as well as a previous effort to wrap MAFFT, independent of BioJulia, in the form of the BiomolecularStructures.jl package @githubbiomolecularstructures, however it appears to have been abandoned with the last release in 2016 which also cannot currently be added to post Julia 1.0 projects as it relies on the old package manager for distribution.

The MAFFT MSA method was created in an effort to reduce CPU load of previous heuristic methods whilst maintaining comparable accuracy by combining the fast Fourier Transform function with an improved scoring system  @katoh2002mafft. The latest iteration, referred to as version 7, was released to address certain limitations, such as misapplication of profile alignments, as well as further improving performance via parallelization and additional optimizations @katoh2013mafft. Clustal Omega represents a rewrite of the Clustal MSA series of programs aimed at addressing bottlenecks with scaling MSA when dealing with high-throughput data via mBed guide trees instead of randomised #cite("blackshields2010sequence", "sievers2014clustal"), as well as incorporating a number of improvements to alignment accuracy, external profile alignment, and iteration #cite("sievers2014clustal", "sievers2011fast"). Finally, the MUSCLE program, with the latest version (5.x.x) referred to as MUSCLE5, runs on a modified Probcons MSA algorithm with multithreading support, coarse (finite sequence) clustering, and additional alterations and capabilities #cite("edgar2021muscle", "do2005probcons"). 

The aforementioned progressive MSA programs are written in C, with the exception of MUSCLE written in C++, and are freely available as open-source software under copyleft licensing #cite("githubmafft", "githubclustal", "githubmuscle"). Official BioJulia wrappers for each method would enable users to conduct multiple sequencing alignment analyses in pure Julia code as opposed to resorting to running MAFFT, Clustal Omega, and MUSCLE as external programs, thus degrading the overall development experience. The workflow would be as follows (note that wrappers in this context will allude to packages that allow for interfacing with software written in alternative languages using a Julia API as opposed to JLLs which represent thin wrappers):
+ Build JLL package recipes with BinaryBuilder.jl @githubbinarybuilder for each program and upload them to the Yggdrasil repository @githubyggdrasil to be shareable. Note that MAFFT_jll already exists, therefore this step would be unnecessary
+ Create Julia wrappers with the JLL packages as primary dependencies (bindings via ccall for MAFFT and Omega Clustal, consider CxxWrap.jl @githubcxxwrap for MUSCLE bindings)
+ Open-source the wrappers and gather feedback from the community
+ Consider additional functionality to better integrate the wrappers into the current BioJulia ecosystem (e.g., be able to plug in BioSequences.jl @biosequences data types directly, include the wrappers for enabling possible backend MSA algorithms for BioAlignments.jl @bioalignments, etc.)
+ Post a stable release for the wrappers, transfer ownership to BioJulia once considered production ready, meaning reliable with minimal bugs and as much functionality is exposed via the Julia written API

== "BioJuliaDocs" central documentation page

Current BioJulia documentation remains decentralized, scattered across various packages as well as conferences, blogs, and other resources. New users or developers wishing to explore the ecosystem will be met with the lack of a global introductory guide, with either #link("https://biojulia.github.io/")[biojulia.github.io] or the organization's Github page at #link("https://github.com/BioJulia")[github.com/BioJulia] representing the main landing pages. Papers have seemingly referenced BioJulia in passing, either focusing on specific packages or focus on the Julia language proper in the context of benefits for biologists #cite("greener2020biostructures", "roesch2021julia"). The SciML organization this year launched the "SciMLDocs" project aiming to produce a global documentation section for their main website that provides an all-encompassing view of the SciML ecosystem, with tutorials, package description and documentation, showcases of unique code samples accomplishing tasks relevant to machine learning, and benchmarks @githubscimldocs. It is powered by Documenter.jl, using markdown files and pure Julia code hosted on a public Github repository to generate publishable documents @githubdocumenter.

The creation of a "BioJuliaDocs" equivalent would not only help to boost discoverability of the BioJulia ecosystem, but also speed up onboarding of potential contributors, highlight exciting developments like the upcoming 1.0 release of Automa.jl @nissen_2023, and emphasize foundational packages, good practices, and code samples proven to be invaluable in a number of bioinformatics/computational biology applications. Content on such a global documentation page would be decided collectively with input from the BioJulia community, as the repository would be open to all members willing to contribute materials. The primary goal for this portion of the project during the JSoC would be to focus on setting up the necessary infrastructure and gathering feedback from BioJulia members on relevant materials and resources to add. 

#pagebreak()

= Timeline

The present timeline remains prospective pending further discussions with my mentor, co-supervisor, and members of the BioJulia community as the project progresses. The project undertaken during the JSoC will be the focus of my honours research thesis which will wrap up in December 2023, allowing for the possibility of either extending the JSoC timeline or simply continuing as a Concordia University student researcher and volunteer.  

#set list(indent: 0pt)

#box[*April 28 to May 28*] 
  - Community bonding period, reach out to fellow mentees
  - Practice C/C++ interop and the BinaryBuilder/Yggdrasil process.
    //- Aid professor Mark Kittisopikul with refining the experimental CodecZstd fork for custom dictionary compression
    - Attempt to build a jll package for the Typst typesetting system @laurenz_haug to be included into Yggdrasil
    - Use the provided Typst_jll package or another JLL package to practice C interop
  - Gather feedback from the BioJulia community on the exact expectations for BioJuliaDocs content, e.g., what packages should be included and discussed, what examples of functionality would best illustrate the power and advantages of the ecosystem, i.e. code snippets for common bioinformatics or computational biology workflows, discuss potential resources such as a citation format

* May 29 - June 04 (Week 01)*
  - Coding period commences
  - Generate a basic, launchable MVP for BioJuliaDocs forked from SciMLDocs @githubscimldocs
  #v(-1em)
  - Finalize the API for each MSA wrapper to enable basic functionality
  
* June 04 - June 11 (Week 02)*
  - Flesh out the introduction section for BioJuliaDocs
    - Basic description
    - "Where to start?"" section
  - Start MAFFT.jl package development (JLL already exists, therefore can jump directly into generating the Julia API)
  
* June 12 - June 18 (Week 03)*
  - Flesh out the "Getting Started" section for BioJuliaDocs
    - "Coming from BioConductor/Biopython" sections
- Extended period for additional MAFFT.jl development if needed (ensure basic functionality, unit tests work correctly)

* June 19 - June 25 (Week 04)*
  - Include "Coming from Python, R" #box[sections] for BioJuliaDocs
  - Wrap up MAFFT.jl basic package development
  - Begin Clustal-Omega.jl package development
  
* June 26 - #JulDate 02 (Week 05)* \
  - Flesh out the "Showcase" section for BioJuliaDocs
  - Wrap up basic Clustal-Omega.jl development
  
* July 03 - July 09 (Week 06)*
  - Flesh out the "Developer Tools" section for BioJuliaDocs (Automa.jl, BioBridgeR.jl, tc.)
  - Extended period for additional Clustal-Omega.jl development if needed
  
* July 10 - July 16 (Week 07)*
  - GSoC midterm evaluation (July 14 deadline)
  - Flesh out the "What is BioJulia" section for BioJuliaDocs
  - Begin MUSCLE.jl package development
  
* July 17 - July 23 (Week 08)*
  - Flesh out the "Other Resources" section for BioJuliaDocs (talks, papers, etc.)
  - Continue development of MUSCLE.jl package (longer development time expected due to switching to C++ bindings, learning CxxWrap.jl)
  
* July 24 - August 20 (Weeks 09 to 12)*
  - Wrap up MUSCLE.jl development 
  - Create comprehensive test sets for each MSA wrapper (ensure adequate code coverage)
  - Ensure complete documentation for each MSA package
  - Continue to gather feedback, add more content to BioJuliaDocs 
  
*August 21 - August 27 (Week 13)*
  - Final week (final work submission, mentor evaluation)
  - Officially launch the BioJuliaDocs page, integrate into the BioJulia website and/or release separately
  - Post stable release for the MSA wrappers

*August 28 - December 2023*
  - Explore further ideas for BioJulia integration or expansion of functionality of MSA wrappers, explore other areas of the BioJulia ecosystem for contributions
    - Integrate MAFFT.jl, Clustal-Omega.jl and MUSCLE.jl as multiple sequence alignment backends within the BioAlignments.jl package
  - Research thesis presentation and report (deadline to be decided by the department)
    - Present works on MSA wrappers OR (alternative topic) meta-discussion on BioJulia (description of the organization and main packages, benchmarks in comparison to similar packages written in other programming languages, etc.)

= Logistics
The JSoC project would be the central focus of my BIOL490 personal honours research thesis to be completed upon graduation in December 2023, again allowing me to continue to further the project after the 13-week deadline either as an extended GSoC contributor or as a volunteer student. I will be available to commit myself full-time (roughly 40 hours per week) with possibly reduced commitment hours during certain periods surrounding the following holidays/special events:

- June 24th weekend: Saint-Jean-Baptiste festivities
- July 1st weekend: Canada Day festivities
- July 14th weekend: Confirmed volunteering event
- August 11th weekend: Possible volunteering event (awaiting event details)

Starting in September, I will be able to contribute roughly 15 to 20 hours per week due to my course obligations as well as preparing for my research report and presentation. I would be able to travel outside Canada to attend conferences or other events such as JuliaCon 2023 if possible.

//I have both a desktop workstation (Ryzen 5 5600G, Radeon RX 6700XT, 16 GB DDR4, SSD storage) running Fedora Silverblue/Windows 11 along with a laptop (Intel Core i7-8550u, 6 GB DDR4, SSD storage) with a similar dual boot setup, which would allow for fast development time with testing on both OS platforms either at home or remotely if need be. I would be willing to travel outside Canada to attend conferences or other events such as JuliaCon 2023 if possible.

= Code Portfolio

One of my proudest achievements was my final bioinformatics class project last session programmed in Julia (#link("https://github.com/M-PERSIC/Persico2022")[github.com/M-PERSIC/Persico2022]). Due to a sudden personal event, I had lost almost half the time I had previously allocated towards working on this project, and still managed to earn 100% thanks to to the breadth of content and overall quality of my work. The paper was rendered using the experimental Quarto typesetting system @Allaire_Quarto_2022 which, while powerful, would often crash or lose savestate, requiring self-diagnosis without documentation and under tight deadlines on top of learning Julia.

The research project was centered on determining the performance of Zstandard custom dictionary compression/decompression on FASTA-formatted data in comparison to more common algorithms such as Zlib or Gzip. The TranscodingStreams.jl package was used extensively for this purpose, offering a programmable with pure Julia code for transcoding data streams to different codecs with ease @sato. Julia was taken full advantage of in other areas too, including absolute state recording (Project.toml/Manifest.toml), use of Pkg artifacts for reproducibility, and BioJulia packages such as FASTX.jl @FASTX and BioSequences.jl @biosequences for generating sequence data.

#figure(image("Compression_Model_Overview.png", width: 80%), caption: [Overview of the workflow relying on TranscodingStreams.jl functionality to apply compression/decompression codecs on FASTA-formatted data, either via Zstandard custom dictionary-based compression (A), or via non-dictionary compression methods (B) @github.])

My personal favourite code sample was the following function that interops with R via RCall.jl @githubrcall to conduct a Tukey's HSD (honestly significant difference) test on compressed/decompressed file size data::
```js
"""
Use The TukeyHSD R package to perform a Tukey's HSD (honestly significant difference) test
"""
function tukey_test_generate(df::DataFrame, filepath::String)
    df_types = robject(df[:,"type"])
    df_sizes = robject(df[:, "size"])
    @rput df_types
    @rput df_sizes
    R"""
    df <- do.call(rbind.data.frame, Map('c', df_types, df_sizes))
    colnames(df) <- c("type", "size")
    model <- aov(size ~ type, data=df)
    tukey_test <- TukeyHSD(model, conf.level=.95)
    library(broom)
    data <- tidy(tukey_test)
    write.csv(data, file="assets/data/results.csv")
    """
end
```
The function splits, then reassembles a dataframe containing compressed/decompressed file size data to perform Tukey's test, and then cleans the resulting output using the R broom package @broom in order to be saved as a csv file for plotting. 


= Glossary
- *BioJulia*: Organization for bioinformatics and computational biology packages in Julia @biojulia_2020
- *Google Summer of Code (GSoC)*: Google-sponsored international annual program for open-source projects @google
- *Guide tree*: Dendogram-esque structure in progressive alignment methods composed of clustered sequences @boyce2014simple
- *JLL*: Thin wrapper over a pre-built binary/executable distributed as a Julia package @jlls
- *Julia*: Dynamic programming language built for scientific computing @Bezanson_Julia_A_fresh_2017 
- *Julia Summer of Code (JSoC)*: Google Summer of Code program led by the Julia organization @jsoc
- *Multiple sequence alignment (MSA)*: Alignment of three or more biological sequences @chowdhury2017review
- *SciML*: Organization dedicated to open-source machine learning packages in Julia @rackauckas2020universal 
- *Yggdrasil*: Central repository for hosting JLL wrappers @githubyggdrasil

= Acknowledgements
I would like to thank professor Ian Ferguson from Concordia University, who is my BIOL490 research thesis coordinator, for feedback as well as helping me pursue research through the JSoC. I would also like to thank professors Kevin Bonham, Jakob Nybo Nissen, and all members of the BioJulia community for their feedback and work towards the Julia community at large. My deepest gratitude to my friends, family, and researchers whose efforts and/or support have allowed me to pursue my education and career path. This paper was realized thanks to the Typst markup-based typesetting system #cite("laurenz_haug", "madje2022programmable").  

