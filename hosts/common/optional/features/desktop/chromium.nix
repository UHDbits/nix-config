# Nix configuration file to set and enable Chromium settings.
{
  programs.chromium = {
    enable = true;
    # Set various policies.
    extraOpts = {
      # Disable Background Mode.
      "BackgroundModeDisabled" = true;

      # Clear browsing data on exit.
      "ClearBrowsingDataOnExitList" = [
        "browsing_history"
        "download_history"
        "cookies_and_other_site_data"
        "cached_images_and_files"
      ];

      # Set a custom profile label.
      "CustomProfileLabel" = "UHDbits";

      # Set the default search engine.
      "DefaultSearchProviderEnabled" = true;
      "DefaultSearchProviderName" = "Google";
      "DefaultSearchProviderSearchURL" = "{google:baseURL}search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:searchClient}{google:sourceId}ie={inputEncoding}";
      "DefaultSearchProviderSuggestURL" = "{google:baseURL}complete/search?output=chrome&q={searchTerms}";
      "DefaultSearchProviderImageURL" = "{google:baseURL}searchbyimage/upload";
      "DefaultSearchProviderImageURLPostParams" = "encoded_image={google:imageThumbnail},image_url={google:imageURL},sbisrc={google:imageSearchSource},original_width={google:imageOriginalWidth},original_height={google:imageOriginalHeight}";
      "DefaultSearchProviderKeyword" = "google";

      # Disable restore on startup.
      "RestoreOnStartup" = 5;
    };
  };
}
