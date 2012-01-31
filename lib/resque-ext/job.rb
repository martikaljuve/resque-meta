require 'resque'
require 'resque/plugins/meta/metadata'

module Resque
	class Job
		def self.create_with_meta(queue, klass, *args)
			meta = Resque::Plugins::Meta::Metadata.new({'meta_id' => klass.meta_id(args), 'job_class' => klass.to_s})
			meta.save
			self.create(queue, klass, meta.meta_id, *args)
			meta
		end
	end
end