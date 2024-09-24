# Job Filter

This script filters job listings from [Bloomberry](https://bloomberry.com/remote-jobs/?utm_source=recommendation&utm_campaign=newsletter_recommendation) emails based on specified criteria. It removes listings for certain job titles and excludes positions requiring 8 or more years of experience. The filtered results are then saved as an HTML file.

## Features

- Filters job listings with the titles "Director," "Staff," "Manager," or "Principal."
- Excludes jobs that require 8 or more years of experience.
- Outputs a filtered HTML file with the remaining job listings.

## Prerequisites

- Ruby (version 2.5 or higher)
- Bundler (to manage gems)

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/cameronbibb/job_filter.git
   cd job_filter
   ```

2. Install dependencies:

   Make sure you have Bundler installed. If not, you can install it using:

   ```bash
   gem install bundler
   ```

   Then run:

   ```bash
   bundle install
   ```

## Usage

1. Copy the raw HTML job listings from your Bloomberry email and paste them into the file called `jobs.txt`. Should look something like this:
   ```text
    Hi YOUR_NAME,<br><br>Here are the newest jobs posted in the past 24 hours tha=
    t other job seekers (except you) will miss. Jobs with salary ranges are sho=
    wn first<br><br>1) <b><a href=3D"https://jobs.lever.co/lucidworks/3a1dc156-=
    8615-40d2-be41-79e621f40748"}">Software Engineer, Platform</a></b> (Remote =
    - Jamaica), Lucidworks - <i> $10745623</i><br><i>5 years of experience. </i=
    ><i> Knowledge of infrastructure provisioning tools like Terraform and a co=
    mmitment to the infrastructure-as-code (IaC) approach.  Ability to think cr=
    itic...</i><br><br>2) <b><a href=3D"https://movableink.com/job-listing?gh_j=
    id=3D6273651"}">Principal Infrastructure Engineer</a></b> (Movable Ink - Re=
    mote US), Movableink - <i> $220k to $240k</i><br><i>10 years of experience.=
    </i><i> Experience running distributed systems in GCP.  Experience with AW=
    S or GCP as an individual contributor, with a strong focus on GCP.  Experie=
    nce in o...</i><br><br>
   ```
2. Run the script:
   ```bash
   ruby filter_jobs.rb
   ```
3. The script will create a `result.html` file with the filtered job listings.

## Customization

- You can modify the list of job titles to exclude by adding or removing words in the regular expression:

  ```ruby
  /\b(director|staff|manager|principal)\b/i
  ```

- Additionally, these keywords don't have to be limited to titles, as you can include other keywords in this expression you would like to filter out (e.g., 'cloud' or 'Java').
- To change the filtering criteria for years of experience, adjust the conditions in the block that processes experience years:
  ```ruby
  filtered_jobs = filtered_jobs.reject do |job|
    if job =~ /\b(\d+)-(\d+)\s+years\s+of\s+experience\b/   # regex matching range of years
      lower_bound = $1.to_i
      lower_bound >= 8
    elsif job =~ /\b(\d+)\s+years\s+of\s+experience\b/      # regex matching specific year
      years_of_experience = $1.to_i
      years_of_experience >= 8
    else
      false
    end
  end
  ```

## How It Works

- The script decodes the content from the `jobs.txt` file.
- It filters out jobs with titles containing certain keywords and removes those requiring 8 or more years of experience.
- The final filtered jobs are saved in an HTML file for easy viewing.

## License

MIT License

## Acknowledgements

[Nokogiri](https://nokogiri.org/) for parsing HTML.
