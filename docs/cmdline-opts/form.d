Long: form
Short: F
Arg: <name=content>
Help: Specify multipart MIME data
Protocols: HTTP SMTP IMAP
Mutexed: data head upload
---
For HTTP protocol family, this lets curl emulate a filled-in form in which a
user has pressed the submit button. This causes curl to POST data using the
Content-Type multipart/form-data according to RFC 2388.

For SMTP and IMAP protocols, this is the mean to compose a multipart mail
message to transmit.

This enables uploading of binary
files etc. To force the 'content' part to be a file, prefix the file name with
an @ sign. To just get the content part from a file, prefix the file name with
the symbol <. The difference between @ and < is then that @ makes a file get
attached in the post as a file upload, while the < makes a text field and just
get the contents for that text field from a file.

Example: to send an image to an HTTP server, where \&'profile' is the name of
the form-field to which portrait.jpg will be the input:

 curl -F profile=@portrait.jpg https://example.com/upload.cgi

To read content from stdin instead of a file, use - as the filename. This goes
for both @ and < constructs. Unfortunately it does not support reading the
file from a named pipe or similar, as it needs the full size before the
transfer starts.

You can also tell curl what Content-Type to use by using 'type=', in a manner
similar to:

 curl -F "web=@index.html;type=text/html" example.com

or

 curl -F "name=daniel;type=text/foo" example.com

You can also explicitly change the name field of a file upload part by setting
filename=, like this:

 curl -F "file=@localfile;filename=nameinpost" example.com

If filename/path contains ',' or ';', it must be quoted by double-quotes like:

 curl -F "file=@\\"localfile\\";filename=\\"nameinpost\\"" example.com

or

 curl -F 'file=@"localfile";filename="nameinpost"' example.com

Note that if a filename/path is quoted by double-quotes, any double-quote
or backslash within the filename must be escaped by backslash.

You can add custom headers to the field by setting headers=, like

  curl -F "submit=OK;headers=\\"X-submit-type: OK\\"" example.com

or

  curl -F "submit=OK;headers=@headerfile" example.com

The headers= keyword may appear more that once and above notes about quoting
apply. When headers are read from a file, Empty lines and lines starting
with '#' are comments and ignored; each header can be folded by splitting
between two words and starting the continuation line with a space; embedded
carriage-returns and trailing spaces are stripped.
Here is an example of a header file contents:

  # This file contain two headers.
.br
  X-header-1: this is a header

  # The following header is folded.
.br
  X-header-2: this is
.br
   another header


To support sending multipart mail messages, the syntax is extended as follows:
.br
- name can be omitted: the equal sign is the first character of the argument,
.br
- if data starts with '(', this signals to start a new multipart: it can be
followed by a content type specification.
.br
- a multipart can be terminated with a '=)' argument.

Example: the following command sends an SMTP mime e-mail consisting in an
inline part in two alternative formats: plain text and HTML. It attaches a
text file:

 curl -F '=(;type=multipart/alternative' \\
.br
         -F '=plain text message' \\
.br
         -F '= <body>HTML message</body>;type=text/html' \\
.br
      -F '=)' -F '=@textfile.txt' ...  smtp://example.com

See further examples and details in the MANUAL.

This option can be used multiple times.
