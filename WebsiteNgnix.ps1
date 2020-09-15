Configuration WebsiteNgnix {

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

      WebServer {
	    Ensure = 'Present'
      # download the ngnix from internet
        explorer.exe 'http://nginx.org/download/nginx-1.19.2.zip'

        Set-Location 'C:\Users\Administrator\Downloads'

      # Unzip the folder
        Expand-Archive -LiteralPath .\nginx-1.19.2.zip -DestinationPath C:\ngnix

      # Chnage dir and start Ngnix on the server
   	    Set-Location C:\nginx
        .\nginx.exe
		}
      
      File WebsiteContent {
	    Ensure = 'Present'
        #Setting content hello world for the web
        Set-Content C:\nginx\nginx-1.19.2\html\index.html '<head></head><body><p>Hello World!</p></body>'
		}

    }
}