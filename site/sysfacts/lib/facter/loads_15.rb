Facter.add(:loads_15) do
  setcode do
    Facter.value(:loads).split(' ')[2]
  end
end
