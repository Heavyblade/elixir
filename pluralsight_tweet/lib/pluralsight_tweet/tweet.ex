defmodule PluralsightTweet.Tweet do
  def tweet(message) do
      ExTwitter.configure(:process, [
         consumer_key:        "cnEFEM8rjuxbhKjC8XtBcnigF",
         consumer_secret:     "4erLoOJWVJude8ZaUYwlDp7ZeUOBcSMnUmwTpG7bgIv64YkdPZ",
         access_token:        "89868220-ABBdtoPtj2yYJAlNEWny7aRMRtoOhNNk4ttew46JG",
         access_token_secret: "Au9f4fXhSsNXU19fToRXMp2XJ0lXVq3PJ03po72Ej7W7C"
       ])
       ExTwitter.update(message)
  end

end
