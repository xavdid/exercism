defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) when rna == "", do: {:ok, []}

  def of_rna(rna) do
    of_rna(rna, [])
  end

  defp of_rna(rna, result) do
    {ins, rest} = String.split_at(rna, 3)

    case {_, amino} = of_codon(ins) do
      {:ok, "STOP"} ->
        {:ok, result}

      {:error, _} ->
        {:error, "invalid RNA"}

      _ ->
        of_rna(rest, result ++ [amino])
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """

  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) when codon == "", do: {:ok, "STOP"}

  def of_codon(codon) do
    case res = @codons[codon] do
      nil ->
        {:error, "invalid codon"}

      _ ->
        {:ok, res}
    end
  end
end
