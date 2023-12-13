Parser_program.config do |parser_program|
    parser_program.web_address = "https://www.imdb.com/chart/top/"
    parser_program.web_address_login = "https://www.imdb.com/ap/signin?openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.imdb.com%2Fregistration%2Fap-signin-handler%2Fimdb_us&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=imdb_us&openid.mode=checkid_setup&siteState=eyJvcGVuaWQuYXNzb2NfaGFuZGxlIjoiaW1kYl91cyIsInJlZGlyZWN0VG8iOiJodHRwczovL3d3dy5pbWRiLmNvbS9jaGFydC90b3AvP3JlZl89bG9naW4ifQ&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&tag=imdbtag_reg-20"
    parser_program.numbers = 30
    parser_program.path = "#{__dir__}/save_files"
    parser_program.path_to_zip = "#{__dir__}/zip/"
    parser_program.file_ext = [".txt", ".json", ".csv", ".yaml"]
    parser_program.condition = ->(item) {item.age_limit == "R" }
    parser_program.age_limits = ["R", "Approved", "PG-13", "16"]


    parser_program.user do |user|
        user.email = "user.for.parsing@gmail.com"
        user.app_password = "ddha nsyy zdtr slgc"
        user.password = "26112023"
    end

    puts parser_program
end
