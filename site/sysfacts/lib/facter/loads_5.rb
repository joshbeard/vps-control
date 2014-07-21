Facter.add(:loads_5) do
  setcode do
    Facter.value(:loads).split(' ')[1]
  end
end
