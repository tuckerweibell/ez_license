require 'json'
require 'set'
require 'csv'

licenses = Set.new

if File.exists?('ez_license/dependencies/npm_deps.json')
	file_1 = File.read('ez_license/dependencies/npm_deps.json')
	hash_1 = JSON.parse(file_1)
	unless hash_1.empty?
		hash_1.each_pair do |k, d|
			nv = k.split('@')
			if nv.count == 3
				name = nv[1]
				version = nv[2]
			else
				name = nv[0]
						version = nv[1]
			end
			license = d["licenses"]
			license = license.sub("MIT*", "MIT")
			url = d["repository"].to_s
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url, "package_manager" => "npm"}
			licenses << temp
		end
	end
end

if File.exists?('ez_license/dependencies/yarn_deps.json')
	file_2 = File.read('ez_license/dependencies/yarn_deps.json')
	hash_2 = JSON.parse(file_2)
	hash_2 = hash_2["data"]["body"]
	unless hash_2.empty?
		hash_2.each do |x|
			name = x[0]
			version = x[1]
			license = x[2]
			license = license.sub("MIT*", "MIT")
			url = x[3]
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url, "package_manager" => "yarn"}
				licenses << temp
		end
	end

end

if File.exists?('ez_license/dependencies/gem_deps.json')
	file_3 = File.read('ez_license/dependencies/gem_deps.json')
	hash_3 = JSON.parse(file_3)
	hash_3 = hash_3["dependencies"]
	unless hash_3.empty?
		hash_3.each do |x|
			name = x["name"]
			version = x["version"]
			license = x["license"]
			license = license.sub("MIT*", "MIT")
			url = x["homepage_url"]
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url, "package_manager" => "bundler"}
			licenses << temp
		end
	end
end

if File.exists?('ez_license/dependencies/python_deps.json')
	file_4 = File.read('ez_license/dependencies/python_deps.json')
	hash_4 = JSON.parse(file_4)
	unless hash_4.empty?
		hash_4.each do |x|
			name = x["Name"]
			version = x["Version"]
			license = x["License"]
			license = license.sub("MIT*", "MIT").sub("MIT License", "MIT").truncate(20)
			url = x["URL"]
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url, "package_manager" => "pip or poetry"}
			licenses << temp
		end
	end
end

licenses = licenses.to_a
headers = ["Name", "Version", "License", "Url", "Package_Manager"]
CSV.open("licenses.csv", "w") do |csv|
	csv << headers
	licenses.each do |l|
		csv << l.values
	end
end
