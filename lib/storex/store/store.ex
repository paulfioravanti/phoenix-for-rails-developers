defmodule Storex.Store do
  @moduledoc false

  alias Storex.Repo
  alias Storex.Store.Book

  def create_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def list_books do
    Book
    |> Repo.all()
  end

  def get_book(id) do
    Book
    |> Repo.get(id)
  end

  def change_book(book \\ %Book{}) do
    book
    |> Book.changeset(%{})
  end

  def update_book(book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def delete_book(book) do
    book
    |> Repo.delete()
  end
end
