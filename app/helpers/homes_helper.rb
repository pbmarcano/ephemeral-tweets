module HomesHelper
  def profile_css(index)
    "#{depths[index]} relative inline-block h-8 w-8 rounded-full ring-2 ring-white dark:ring-slate-800" 
  end

  private

  def depths
    [
      "z-50",
      "z-40",
      "z-30",
      "z-20",
      "z-10",
      "z-0"
    ]
  end
end
