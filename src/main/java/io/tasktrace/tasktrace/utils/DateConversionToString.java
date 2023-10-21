package io.tasktrace.tasktrace.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class DateConversionToString {
    public static String getFormattedDate(LocalDate date, String stringFormat)
    {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(stringFormat, Locale.ENGLISH);
        return date.format(formatter);
    }

}
