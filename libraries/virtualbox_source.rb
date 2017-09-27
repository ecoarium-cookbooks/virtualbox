require 'open-uri'

class VirtualboxSource
  class << self

    @@base_url = nil
    def base_url=(value)
      @@base_url = value
    end
    def base_url
      @@base_url
    end

    @@file_extension = nil
    def file_extension=(value)
      @@file_extension = value
    end
    def file_extension
      @@file_extension
    end

    @@checksum_extension = nil
    def checksum_extension=(value)
      @@checksum_extension = value
    end
    def checksum_extension
      @@checksum_extension
    end

    def create_url(full_version)
       short_version, build = full_version.split("-")
      "#{base_url}/#{short_version}/VirtualBox-#{full_version}-#{file_extension}"
    end

    def get_checksum(url)
      sha256sum = nil
      sha256sum = open("#{File.dirname(url)}/SHA256SUMS").grep(/#{checksum_extension}/)[0].split(" ")[0] rescue nil
      raise "unable to find checksum for #{url}" if sha256sum.nil?
      sha256sum
    end

  end
end