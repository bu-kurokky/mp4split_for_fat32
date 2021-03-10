# coding: utf-8
require 'time'
require 'filesize'

DEBUG=true
LIMIT_GB=3.8

class Main
	def initialize(argv)
		@file = argv
		@dir_name  = File.dirname(@file)
		@base_name = File.basename(@file)
	end
	def get_total_time
		ret = `ffmpeg -i #{@file} 2>&1 | grep "Duration"`
		total_time = ret.gsub(/,.+|\n|\..+/,"").gsub(/.+Duration: /,"")
		return total_time
	end
	def get_split_count
		file_size = File.stat(@file).size
		file_size = Filesize.from("#{file_size} B").to_f('GB') + 1.0
		file_size = file_size.to_s.gsub(/\..+/,"").to_i
		split_count = (file_size/LIMIT_GB).round + 1
		return split_count
	end
	def calculation_total_minutes
		total_times_array = get_total_time.split(":").reverse
		# add buffer
		total_minutes = total_times_array[1].to_i + 1
		if total_times_array[2]
			total_minutes += total_times_array[2].to_i*60
		end
		return total_minutes
	end
	def get_setting
		setting = Hash.new
		# add buffer
		split_count   = get_split_count + 1
		total_minutes = calculation_total_minutes
		split_minute  = total_minutes/split_count
		setting['split_count']  = split_count
		setting['split_minute'] = split_minute
		return setting
	end
	def sec2hms(sec)
		time = sec
		sec = time % 60
		time /= 60
		mins = time % 60
		time /= 60
		hours = time % 24
		return [sprintf("%02d",hours), sprintf("%02d",mins), sprintf("%02d",sec)].join(":")
	end
	def split_mp4
		setting = get_setting
		setting['split_count'].times do |n|
			begin_time = sec2hms(n*setting['split_minute']*60)
			cmd = "ffmpeg -ss #{begin_time} -i '#{@file}' -t #{setting['split_minute']*60} -c copy '#{@file.gsub('.mp4',"")}_#{sprintf("%03d",n+1)}.mp4'"
			if DEBUG
				puts cmd
			else
				`#{cmd}`
			end
		end
	end
end

if !ARGV[0]
	puts "---------------------------"
	puts "Not find argv"
	puts ""
	puts "ruby #{__FILE__} target.mp4"
	puts "---------------------------"
	sleep 0.5
	exit
end
if ARGV[0] !~ /mp4$/
	puts "---------------------------"
	puts "Please choose mp4 file"
	puts "---------------------------"
	sleep 0.5
	exit
end

main = Main.new(ARGV[0])
main.split_mp4
