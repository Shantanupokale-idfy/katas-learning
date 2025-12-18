defmodule ElixirKatasWeb.Kata70OptimisticLive do
  use ElixirKatasWeb, :live_view
  import ElixirKatasWeb.KataComponents

  def mount(_params, _session, socket) do
    source_code = File.read!(__ENV__.file)
    notes_content = File.read!("notes/kata_70_optimistic_notes.md")

    socket =
      socket
      |> assign(active_tab: "notes")
      |> assign(source_code: source_code)
      |> assign(notes_content: notes_content)
      |> assign(:saving, false)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.kata_viewer 
      active_tab={@active_tab} 
      title="Kata 70: Optimistic UI" 
      source_code={@source_code} 
      notes_content={@notes_content}
    >
      <div class="p-6 max-w-2xl mx-auto">
        <div class="mb-6 text-sm text-gray-500">
           Interactive optimistic ui demonstration.
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border">

          <div class="space-y-4">
            <button phx-click="save_optimistic" class="px-4 py-2 bg-indigo-600 text-white rounded">
              Save (Optimistic)
            </button>
            <%= if @saving do %>
              <div class="p-4 bg-yellow-50 border border-yellow-200 rounded">
                <span class="text-yellow-800">Saving... (optimistic update shown immediately)</span>
              </div>
            <% else %>
              <div class="p-4 bg-green-50 border border-green-200 rounded">
                <span class="text-green-800">✓ Saved successfully</span>
              </div>
            <% end %>
          </div>
    
        </div>
      </div>
    </.kata_viewer>
    """
  end

  def handle_event("increment", _, socket), do: {:noreply, update(socket, :count, &(&1 + 1))}
  def handle_event("decrement", _, socket), do: {:noreply, update(socket, :count, &(&1 - 1))}
  def handle_event("add_item", _, socket), do: {:noreply, update(socket, :items, &(&1 ++ ["New item"]))}
  def handle_event("remove_item", %{"idx" => idx}, socket) do
    idx = String.to_integer(idx)
    {:noreply, update(socket, :items, &List.delete_at(&1, idx))}
  end
  def handle_event("update_message", %{"value" => val}, socket), do: {:noreply, assign(socket, :message, val)}
  def handle_event("self_click", _, socket), do: {:noreply, update(socket, :clicks, &(&1 + 1))}
  def handle_event("send_to_parent", _, socket), do: {:noreply, assign(socket, :child_message, "Hello from child!")}
  def handle_event("sibling_a_send", _, socket), do: {:noreply, assign(socket, :sibling_data, "Data from A")}
  def handle_event("load_component", _, socket), do: {:noreply, assign(socket, :loaded, true)}
  def handle_event("submit_form", params, socket), do: {:noreply, assign(socket, :form_data, params)}
  def handle_event("create_item", _, socket), do: {:noreply, update(socket, :items, &(&1 ++ ["New item"]))}
  def handle_event("delete_item", %{"idx" => idx}, socket) do
    idx = String.to_integer(idx)
    {:noreply, update(socket, :items, &List.delete_at(&1, idx))}
  end
  def handle_event("save_optimistic", _, socket) do
    socket = assign(socket, :saving, true)
    Process.send_after(self(), :save_complete, 1000)
    {:noreply, socket}
  end

  def handle_event("set_tab", %{"tab" => tab}, socket) do
    {:noreply, assign(socket, active_tab: tab)}
  end

  def handle_info(:save_complete, socket) do
    {:noreply, assign(socket, :saving, false)}
  end
end
