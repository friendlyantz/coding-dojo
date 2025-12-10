use unicode_segmentation::UnicodeSegmentation;

pub fn reverse(input: &str) -> String {
    let graphemes = UnicodeSegmentation::graphemes(input, true)
        .collect::<Vec<&str>>();
    // let reversed: String = input.chars().rev().collect();
    let reversed: String = graphemes
        .into_iter()
        .rev()
        .collect();

    reversed
}
