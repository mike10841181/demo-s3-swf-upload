module S3SwfUpload
  module ViewHelpers
    def s3_swf_upload_tag(options = {})
      height     = options[:height] || 35
      width      = options[:width]  || 300
      success    = options[:success]  || ''
      failed     = options[:failed]  || ''
      selected   = options[:selected]  || ''
      canceled   = options[:canceled] || ''
      prefix     = options[:prefix] || 's3_swf'
      upload     = options[:upload] || 'Upload' 
      initial_message    = options[:initial_message] || 'Select file to upload...'

      prefix = prefix + "/" unless prefix == ""

      @include_s3_upload ||= false 
      @count ||= 1
      
      out = ""

      if !@include_s3_upload
        out << '<script type="text/javascript" src="/javascripts/s3_upload.js"></script>' 
        @include_s3_upload = true
      end

      out << %(<script type="text/javascript">
            var s3_swf#{@count} = s3_swf_init('s3_swf#{@count}', {
              width:  #{width},
              height: #{height},
              initialMessage: '#{initial_message}',
              onSuccess: function(filename, filesize){
                #{success}
              },
              onFailed: function(status){
                #{failed}
              },
              onFileSelected: function(filename, size){
                #{selected}
              },
            });
        </script>

        <div id="s3_swf#{@count}">
          Please <a href="http://www.adobe.com/go/getflashplayer">Update</a> your Flash Player to Flash v9.0.1 or higher...
        </div>

        <div class="s3-swf-upload-link">
        <a href="#" onclick="s3_swf#{@count}.upload('#{prefix}')">#{upload}</a>
        </div>
      )
      
      @count += 1
      out

    end

  end
end

ActionView::Base.send(:include, S3SwfUpload::ViewHelpers)
