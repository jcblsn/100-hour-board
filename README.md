100-hour-board
================

## What is this?

This repository contains an archive of the [100 Hour Board](https://100hourboard.org), a now-defunct question-answering service that was run by students at Brigham Young University from the late 1990s to 2021. The service existed first as a physical bulletin board and later as a website where students could post questions and receive answers from a rotating group of long-term volunteers. Questions spanned a wide range of topics—from academic to personal to philosophical.

The archive consists of over 150,000 responses to more than 85,000 questions posted to the board website between 1998 and 2021. It also contains categories associated with each question along with a small number of comments.

## Why is the 100 Hour Board interesting?

### As a time capsule

The 100 Hour Board represents a kind of running time capsule of BYU student life for the duration of its existence. The questions and answers posted to the board are a record of the shifting concerns, interests, and experiences of students over a 20-year period; those interested in LDS culture or the history of the internet may find it a compelling resource for that reason.

### As a dataset

It’s also a fairly clean structured dataset and a good candidate for text analysis by data scientists or others looking for project ideas. Additionally, the `100-hour-board-question_categories.parquet` file contains the categories associated with each question which may have some interesting relevance to a classification or topic modeling project.

## How do I use this?

For convenience, there are two copies of the archive: one with the original HTML markup from the website (`files/html`) and one with the markup removed and text converted to Markdown syntax (`files/markdown`).

**HTML example**

    "\n    <span class=\"\"leadin\"\">Q:</span>\n    <p>Dear 100 Hour Board,<br><br>I had never read about BYU's mission statement including a \"\"quest for perfection\"\" before <a class=\"\"webtxtlink\"\" href=\"\"https://100hourboard.org/questions/75867/\"\" title=\"\"Board Question #75867\"\">Board Question #75867</a>. I know I have strong perfectionist tendencies, to the detriment of my happiness. Do you think this attitude afflicts BYU graduates disproportionately? What's the value in perfectionism?<br><br>---Portia</p>"

**Markdown example**

    "Q:\n\nDear 100 Hour Board,  \n  \nI had never read about BYU's mission statement including a \"quest for perfection\" before [Board Question #75867](https://100hourboard.org/questions/75867/). I know I have strong perfectionist tendencies, to the detriment of my happiness. Do you think this attitude afflicts BYU graduates disproportionately? What's the value in perfectionism?  \n  \n\\---Portia"

In both cases, the archive is stored in the [Apache Parquet](https://parquet.apache.org/) format. The files are named as follows:

-   `100-hour-board-questions-[html/md].parquet` contains questions and associated metadata
-   `100-hour-board-responses-[html/md].parquet` contains responses to questions
-   `100-hour-board-comments-[html/md].parquet` contains comments and associated metadata
-   `100-hour-board-question_categories-[html/md].parquet` contains the categories associated with each question (note that hyphens originally represented nested categories)

The files can be joined using the `question_id` column. A date column for questions and comments can be produced using the `scripts/parse_dates.R` script. Responses to questions were not dated.

This repository does not contain any media files associated with the original website.

## Example

As an illustration, I’ve included a preview of an individual question and its associated responses here. The excerpts shown are representative of the format and styled used for most questions (especially regarding the use of pseudonyms for both question-askers and -answerers). There is no comment data for this question, as is the case for most questions as comments served a function closer to correction than discussion.

`100-hour-board-questions-markdown.parquet`

| question_id | question_info                                    | question_text                                                                                   |
|------------:|:-------------------------------------------------|:------------------------------------------------------------------------------------------------|
|       75949 | Question \#75949 posted on 01/18/2014 12:30 p.m. | Q: Dear 100 Hour Board, I had never read about BYU’s mission statement including a “quest for … |

`100-hour-board-responses-markdown.parquet`

| question_id | response_id | response_byline                                                      | response_text                                                                                       |
|------------:|------------:|:---------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------|
|       75949 |      130494 | written by [Haleakalā](https://100hourboard.org/aliases/7810/)       | A: Dear Portia, It’s worth clarifying for those who didn’t click on the link that I only quoted th… |
|       75949 |      130511 | written by [Anne, Certainly](https://100hourboard.org/aliases/7768/) | A: Dear Portia, I wouldn’t be surprised to hear that perfectionism disproportionately affects BYU,… |

`100-hour-board-question_categories.parquet`

| question_id | question_category |
|------------:|:------------------|
|       75949 | BYU - Culture     |
|       75949 | Self Improvement  |

## Contributions

If you have any questions or suggestions, feel free to open an issue or pull request.

If you make something interesting using this data, I’d like to hear about it!

## Source

While the 100 Hour Board was most recently hosted at [100hourboard.org](https://100hourboard.org), it was taken down in 2021.

I created this dataset by scraping the archived version of the site at [web.archive.org](https://web.archive.org) using Python. This functioned as a personal project to help me learn the language better. My code is available in the `scripts` directory.

## Attribution

The 100 Hour Board was created and run by students at Brigham Young University. While active, it ran the following disclaimer:

> This site, and the opinions and statements contained herein, do not necessarily reflect the beliefs or policies of Brigham Young University, The Church of Jesus Christ of Latter-day Saints, or any of their affiliates.

This repository is not affiliated with BYU, the LDS church, or the 100 Hour Board. Its contents are provided as-is for research purposes only, with no warranty or guarantee of accuracy. Any use of this content should be accompanied by appropriate attribution, including a citation of the original source and acknowledgement of any individual works or contributors that are included.
