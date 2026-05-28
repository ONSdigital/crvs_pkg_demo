##### Creating the Excel workbook ----------------------------------------------

wb <- openxlsx::createWorkbook(
  creator = NULL,
  title = birth_excel_title
)

births_range <- paste(min(birth_years), "to", max(birth_years))

##### Cover sheet --------------------------------------------------------------

cover_sheet_text <- read.csv(
  excel_input$cover_sheet_source,
  header = FALSE,
  sep = "\t",
  fileEncoding = "UTF-8-BOM"
)

cover_sheet_links <- data.frame(
  rows = cover_sheet_cfg$cover_sheet_links_rows,
  links = cover_sheet_cfg$cover_sheet_links
)

replacements <- data.frame(
  replace = c(
    "!birth_excel_title!",
    "!source!",
    "!release_date!",
    "!current_year!",
    "!contact_email!",
    "!contact_phone!",
    "!publication_copyright_yr!",
    "!birth_excel_title!",
    "!table_4.2_heading!",
    "!table_4.3_heading!",
    "!table_4.4_heading!",
    "!table_4_5_heading!",
    "!table_4_6_heading!",
    "!table_4_5_6_heading!",
    "!table_4.7_heading!"
  ),
  with = c(
    birth_excel_title,
    excel_input$data_source,
    excel_input$publication_date,
    format(Sys.Date(), format = "%Y"),
    excel_input$contact_email,
    excel_input$contact_phone,
    excel_input$publication_copyright_yr,
    birth_excel_title,
    paste(birth_table_headings$table_4_2, births_range),
    paste(birth_table_headings$table_4_3, births_range),
    paste(birth_table_headings$table_4_4, births_range),
    paste(birth_table_headings$table_4_5, births_range),
    paste(birth_table_headings$table_4_6, births_range),
    paste(birth_table_headings$table_4_5_6, births_range),
    paste(birth_table_headings$table_4_7, births_range)
  )
)

rapid.spreadsheets::create_cover_sheet(
  wb,
  text_df = cover_sheet_text,
  subheadings = 4,
  rows_to_bold = c(2:3),
  hyperlinks = cover_sheet_links,
  replacements = replacements
)

##### Contents -----------------------------------------------------------------

contents_sheet_text <- read.csv(
  excel_input$contents_file,
  header = TRUE,
  sep = "\t",
  fileEncoding = "UTF-8-BOM",
  check.names = FALSE
)

contents_sheet_text <- rapid.spreadsheets:::replace_text_for_spreadsheets(
  replacements,
  contents_sheet_text
)

rapid.spreadsheets::create_contents_notes(
  wb,
  df = contents_sheet_text,
  border_type = "vertical"
)

##### Notes --------------------------------------------------------------------

notes_sheet_text <- read.csv(
  excel_input$notes_file,
  header = TRUE,
  sep = "\t",
  fileEncoding = "UTF-8-BOM",
  check.names = FALSE
)

notes_sheet_links_df <- data.frame(
  rows = notes_sheet_cfg$notes_sheet_links_rows,
  links = notes_sheet_cfg$notes_sheet_links
)

rapid.spreadsheets::create_contents_notes(
  wb,
  df = notes_sheet_text,
  tab_name = "Notes",
  hyperlinks = notes_sheet_links_df,
  border_type = "vertical"
)

##### Data tables --------------------------------------------------------------

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_2,
  tab_name = "Table_4.2",
  heading = paste(birth_table_headings$table_4_2, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 4,
  column_width = c(10, 20, 15, 20),
  border_type = "vertical",
  additional_text = c(notes_per_table$notes_tab4_2)
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_3,
  tab_name = "Table_4.3",
  heading = paste(birth_table_headings$table_4_3, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 4,
  column_width = c(10, 15, 25, 20),
  border_type = "vertical",
  additional_text = c(notes_per_table$notes_tab4_3)
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_4,
  tab_name = "Table_4.4",
  heading = paste(birth_table_headings$table_4_4, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 4,
  column_width = c(10, 10, 15, 15),
  border_type = "vertical",
  additional_text = c(notes_per_table$notes_tab4_4)
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_5,
  tab_name = "Table_4.5",
  heading = paste(birth_table_headings$table_4_5, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 5,
  column_width = c(10, 15, 15, 20, 20),
  border_type = "vertical",
  additional_text = notes_per_table$notes_tab4_5_6
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_6,
  tab_name = "Table_4.6",
  heading = paste(birth_table_headings$table_4_6, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 5,
  column_width = c(10, 15, 15, 20, 20),
  border_type = "vertical",
  additional_text = notes_per_table$notes_tab4_5_6
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_5_6,
  tab_name = "Table_4.5_4.6",
  heading = paste(birth_table_headings$table_4_5_6, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 5,
  column_width = c(10, 25, 15, 20, 20),
  border_type = "vertical",
  additional_text = notes_per_table$notes_tab4_5_6
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_7,
  tab_name = "Table_4.7",
  heading = paste(birth_table_headings$table_4_7, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = 5,
  column_width = c(10, 15, 25, 15, 20),
  border_type = "vertical",
  additional_text = notes_per_table$notes_tab4_7
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_8,
  tab_name = "Table_4.8",
  heading = paste(birth_table_headings$table_4_8, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = c(3, 4),
  two_decimal = 5,
  column_width = c(10, 25, 20, 10, 15),
  border_type = "vertical",
  additional_text = notes_per_table$notes_tab4_8
)

rapid.spreadsheets::create_data_table_tab(
  wb,
  df = tab4_9,
  tab_name = "Table_4.9",
  heading = paste(birth_table_headings$table_4_9, births_range),
  left_align = 1,
  num_char_cols = 1,
  no_decimal = c(4, 5),
  one_decimal = 6,
  column_width = c(10, 20, 25, 20, 10, 25),
  border_type = "vertical",
  additional_text = notes_per_table$notes_tab4_9
)

##### Save out -----------------------------------------------------------------

openxlsx::saveWorkbook(
  wb,
  paste0("outputs/births_excel.xlsx"),
  overwrite = TRUE
)
