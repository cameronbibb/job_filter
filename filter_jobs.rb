require 'nokogiri'

encoded_content = File.read('jobs.txt')

decoded_content = encoded_content.unpack("M").first.force_encoding(Encoding::ISO_8859_1).encode(Encoding::UTF_8)
decoded_content = decoded_content.split('<br><br>').filter { |elem| elem =~ /^\d+\)/ }

# filter out jobs with specific words: director, staff, manager, or principal
filtered_jobs = decoded_content.filter {|job| job !~ /\b(director|staff|manager|principal)\b/i }

# filter out jobs requiring 8 or more years of experience
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

jobs_string = filtered_jobs.join('<br><br>')

html_doc = Nokogiri::HTML(jobs_string)
File.open("result.html", "w") { |f| f.write html_doc }

puts 'filtering complete'