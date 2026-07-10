// Copyright (c) 2014 - 2023 UNICEF. All rights reserved.

import { fromJS } from "immutable";
import { getSearchByOptions } from "./search-form";

describe("<SearchForm />", () => {
  it("formats search-by select options using display_name helper and falls back to field name", () => {
    const fields = [
      {
        name: "family_name",
        display_name: fromJS({ en: "Family Name", es: "Nombre de Familia" })
      },
      {
        name: "family_size",
        display_name: fromJS({})
      },
      {
        name: "registry_location_current",
        display_name: fromJS({ en: "Location" })
      }
    ];

    const options = getSearchByOptions(fields, "es", { t: key => (key === "fields.family_size" ? "No. de Integrantes de la Familia" : key) });

    expect(options).toEqual([
      { id: "family_name", display_text: "Nombre de Familia" },
      { id: "family_size", display_text: "No. de Integrantes de la Familia" }
    ]);
  });
});
