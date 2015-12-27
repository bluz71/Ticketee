class TagsController < ApplicationController
  def remove
    @ticket = Ticket.find(params[:ticket_id])
    @tag = Tag.find(params[:id])
    authorize @ticket, :tag?

    @ticket.tags.destroy(@tag)

    # Return a 200 OK status to the browser.
    head :ok
  end
end
