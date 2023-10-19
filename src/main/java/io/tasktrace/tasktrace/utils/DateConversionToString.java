package io.tasktrace.tasktrace.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateConversionToString {
    public static String getFormattedDate(LocalDate date, DateTimeFormatter formatter)
    {
        formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        return date.format(formatter);
    }

}
