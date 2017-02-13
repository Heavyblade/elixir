defmodule PluralsightTweet.Scheduler do
    def schedule_file(schedule, file) do
        Quantum.add_job(schedule, fn ->
            PluralsightTweet.FileReader.get_strings_to_tweet(file)
            |> PluralsightTweet.Tweet.tweet
        end)
    end
end
