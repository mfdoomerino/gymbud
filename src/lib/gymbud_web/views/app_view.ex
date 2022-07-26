defmodule GymbudWeb.AppView do
  use GymbudWeb, :view

  def is_active(section, current) do
    if section == current do
      "text-sm border border-gray-200 bg-[#5464FF] text-white p-1 w-fit rounded-lg cursor-pointer"
    else
      "text-sm border border-gray-200 bg-white p-1 w-fit rounded-lg cursor-pointer"
    end
  end
end
