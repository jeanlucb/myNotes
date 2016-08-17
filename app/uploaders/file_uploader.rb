# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog
  

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process :set_content_type

  def convert_to_image(height, width)
    begin
      image = ::Magick::Image.read(current_path + "[0]")[0]
    rescue Magick::ImageMagickError
      image = ::Magick::Image.read("public/gnome_text_x_generic.png")[0]
    end
    image.resize_to_fit(height,width).write(current_path)
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  version :thumb do
    process convert_to_image: [200,200]
    process :convert => :png

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
    end
  end

  version :small_thumb do
    process convert_to_image: [75,75]
    process :convert => :png

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
    end
  end

  version :cover do
    process convert_to_image: [500,500]
    process :convert => :png

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.png'
    end
  end

  protected

    def is_image?(new_file)
      new_file.content_type.start_with? 'image'
    end

    def is_document?(new_file)
      new_file.content_type.start_with? 'application'
    end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
