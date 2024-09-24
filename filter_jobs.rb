require 'nokogiri'

encoded_content = File.read('jobs.txt')

decoded_content = encoded_content.unpack("M").first.force_encoding(Encoding::ISO_8859_1).encode(Encoding::UTF_8)
decoded_content = decoded_content.split('<br><br>').filter { |elem| elem =~ /^\d+\)/ }

filtered_jobs = decoded_content.filter {|job| job !~ /\b(director|staff|manager|principal)\b/i }
filtered_jobs = filtered_jobs.reject do |job|
  if job =~ /\b(\d+)-(\d+)\s+years\s+of\s+experience\b/
    lower_bound = $1.to_i
    lower_bound >= 8
  elsif job =~ /\b(\d+)\s+years\s+of\s+experience\b/
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