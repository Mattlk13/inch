# NodeJS's configuration
# Node will be treated as a separate programming language for now

Inch::Config.for(:nodejs) do
  codebase do
    include_files ["src/**/*.js"]
    exclude_files []
  end
end
